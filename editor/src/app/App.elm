port module App exposing (..)

import Maybe
import Browser
import Browser.Dom
import Json.Encode as JE
import Json.Decode as JD
import Dict exposing (Dict)
import Draggable exposing (Delta)
import Draggable.Events exposing (onDragBy, onMouseDown)
import Html.Styled.Events exposing (keyCode, on, onClick, onInput, targetValue)
import Html.Styled.Attributes exposing (disabled, fromUnstyled, placeholder, value)
import Html.Styled exposing (Html, button, div, input, label, li, option, select, text, ul, toUnstyled)
import Numeral
import Types exposing (..)
import Serializers exposing (..)
import Styles exposing (..)


port selectProjectOut : () -> Cmd msg


port selectProjectIn : (String -> msg) -> Sub msg


port loadLevelOut : String -> Cmd msg


port loadLevelIn : (( String, String ) -> msg) -> Sub msg


port saveLevelOut : ( String, JD.Value ) -> Cmd msg


availableComponents : List Component
availableComponents =
    [ Ability {}
    , Aggression { x = 0, y = 0, width = 0, height = 0, duration = 0 }
    , Animation {}
    , Attack {}
    , Checkpoint { index = 0 }
    , Container {}
    , Damage { hitpoints = 0 }
    , Fixture { x = 0, y = 0 }
    , Health { hitpoints = 0, armor = 0 }
    , Input {}
    , Movement {}
    , Platform { fall = 1, initialX = 0, initialY = 0 }
    , Player { alias = "", money = 0, lives = 100, documents = 0, checkpoint = 1 }
    , Position { x = 0, y = 0 }
    , Projectile {}
    , Snare {}
    , Sound {}
    , Sprite { asset = "" }
    , Trigger {}
    , Wave { type_ = "circular", x = 0, y = 0, amplitude = 1, frequency = 0.5 }
    , Waypoint { speed = 1, waypoints = [] }
    ]


toComponentId : Component -> String
toComponentId component =
    case component of
        Ability _ ->
            "ability"

        Aggression _ ->
            "aggression"

        Animation _ ->
            "animation"

        Attack _ ->
            "attack"

        Checkpoint _ ->
            "checkpoint"

        Container _ ->
            "container"

        Damage _ ->
            "damage"

        Fixture _ ->
            "fixture"

        Health _ ->
            "health"

        Input _ ->
            "input"

        Movement _ ->
            "movement"

        Platform _ ->
            "platform"

        Player _ ->
            "player"

        Position _ ->
            "position"

        Projectile _ ->
            "projectile"

        Snare _ ->
            "snare"

        Sound _ ->
            "sound"

        Sprite _ ->
            "sprite"

        Trigger _ ->
            "trigger"

        Wave _ ->
            "wave"

        Waypoint _ ->
            "waypoint"


lastId : List Entity -> Int
lastId entities =
    case List.maximum <| List.map (\e -> e.id) entities of
        Nothing ->
            0

        Just id ->
            id


sortEntityList : List Entity -> List Entity
sortEntityList list =
    List.sortWith
        (\a b ->
            case compare a.id b.id of
                LT ->
                    GT

                EQ ->
                    EQ

                GT ->
                    LT
        )
        list


toInt : Int -> String -> Int
toInt default value =
    if value == "" then
        0
    else
        case String.toInt value of
            Nothing ->
                default

            Just int ->
                int


toFloat : Float -> String -> Float
toFloat default value =
    if value == "" then
        0.0
    else
        case String.toFloat value of
            Nothing ->
                default

            Just int ->
                int


onBlur : (String -> Msg) -> Html.Styled.Attribute Msg
onBlur handler =
    on "blur" (JD.map handler targetValue)


onEnter : (String -> msg) -> Html.Styled.Attribute msg
onEnter tagger =
    let
        isEnter code =
            if code == 13 then
                JD.succeed ""
            else
                JD.fail ""

        decodeEnter =
            JD.andThen isEnter keyCode
    in
        on "keydown" <|
            JD.map2
                (\_ value -> tagger value)
                decodeEnter
                targetValue


dragConfig : Draggable.Config () Msg
dragConfig =
    Draggable.basicConfig OnDragBy


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view >> toUnstyled
        , update = update
        , subscriptions = subscriptions
        }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( initialModel
    , Cmd.none
    )


initialModel : Model
initialModel =
    { tree = Nothing
    , selectedDirectory = ""
    , selectedFile = ""
    , selectedEntity = Nothing
    , selectedComponent = Nothing
    , queuedComponent = Nothing
    , levelParseError = Nothing
    , levelId = 0
    , levelName = ""
    , entities = Dict.empty
    , nextId = 0
    , drag = Draggable.init
    , position = { x = 50, y = 50 }
    }


createEntity : Int -> String -> Entity
createEntity id label =
    { id = id
    , label = label
    , position = { x = 0, y = 0 }
    , components = Dict.empty
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DragMsg dragMsg ->
            Draggable.update dragConfig dragMsg model

        OnDragBy ( dx, dy ) ->
            let
                position =
                    Debug.log "pt" (Point (model.position.x + dx) (model.position.y + dy))
            in
                ( { model | position = position }
                , Cmd.none
                )

        NoOp ->
            ( model, Cmd.none )

        SelectProjectOut ->
            ( model, selectProjectOut () )

        SelectProjectIn json ->
            case decodeTree json of
                Err err ->
                    ( model, Cmd.none )

                Ok tree ->
                    ( { model | tree = Just tree }, Cmd.none )

        LoadLevelOut file ->
            ( model, loadLevelOut (file) )

        LoadLevelIn ( file, json ) ->
            case decodeLevel json of
                Err err ->
                    ( { model
                        | levelParseError = Just "Invalid file format"
                      }
                    , Cmd.none
                    )

                Ok level ->
                    let
                        nextId =
                            lastId (Dict.values level.entities)
                    in
                        ( { model
                            | selectedFile = file
                            , levelParseError = Nothing
                            , levelId = level.id
                            , levelName = level.name
                            , entities = level.entities
                            , nextId = nextId
                          }
                        , Cmd.none
                        )

        SaveLevel ->
            ( model
            , saveLevelOut
                ( model.selectedFile
                , encodeLevel model.levelId model.levelName model.entities
                )
            )

        SetLevelId id ->
            let
                newId =
                    toInt model.levelId id
            in
                ( { model | levelId = newId }, Cmd.none )

        SetLevelName name ->
            ( { model | levelName = name }, Cmd.none )

        AddEntity ->
            let
                nextId =
                    model.nextId + 1

                entity =
                    createEntity nextId ""

                entities =
                    Dict.insert (String.fromInt entity.id) entity model.entities
            in
                ( { model | nextId = nextId, entities = entities, selectedEntity = Just entity }, Cmd.none )

        RemoveEntity ->
            let
                ( selectedEntity, entities ) =
                    case model.selectedEntity of
                        Nothing ->
                            ( model.selectedEntity, model.entities )

                        Just entity ->
                            ( Nothing, Dict.remove (String.fromInt entity.id) model.entities )
            in
                ( { model | selectedEntity = selectedEntity, entities = entities }, Cmd.none )

        SelectEntity entity ->
            ( { model | selectedEntity = Just entity, selectedComponent = Nothing }, Cmd.none )

        SelectComponent component ->
            let
                componentId =
                    toComponentId component
            in
                ( { model | queuedComponent = Nothing, selectedComponent = Just componentId }, Cmd.none )

        AddComponent component ->
            let
                ( selectedEntity, entities ) =
                    case model.selectedEntity of
                        Nothing ->
                            ( Nothing, model.entities )

                        Just entity ->
                            let
                                id =
                                    toComponentId component

                                components =
                                    Dict.insert id component entity.components

                                newEntity =
                                    { entity | components = components }
                            in
                                ( Just newEntity, Dict.insert (String.fromInt newEntity.id) newEntity model.entities )
            in
                ( { model
                    | queuedComponent = Nothing
                    , selectedComponent = Just <| toComponentId component
                    , selectedEntity = selectedEntity
                    , entities = entities
                  }
                , Cmd.none
                )

        RemoveComponent componentId ->
            let
                ( selectedEntity, entities ) =
                    case model.selectedEntity of
                        Nothing ->
                            ( Nothing, model.entities )

                        Just entity ->
                            let
                                components =
                                    Dict.remove componentId entity.components

                                newEntity =
                                    { entity | components = components }
                            in
                                ( Just newEntity, Dict.insert (String.fromInt newEntity.id) newEntity model.entities )
            in
                ( { model
                    | selectedComponent = Nothing
                    , selectedEntity = selectedEntity
                    , entities = entities
                  }
                , Cmd.none
                )

        UpdateComponent component ->
            let
                ( selectedEntity, newEntities ) =
                    case model.selectedEntity of
                        Nothing ->
                            ( model.selectedEntity, model.entities )

                        Just entity ->
                            let
                                componentId =
                                    toComponentId component

                                components =
                                    Dict.insert componentId component entity.components

                                newEntity =
                                    { entity | components = components }
                            in
                                ( Just newEntity, Dict.insert (String.fromInt newEntity.id) newEntity model.entities )
            in
                ( { model | entities = newEntities, selectedEntity = selectedEntity }, Cmd.none )

        QueueComponent component ->
            ( { model | queuedComponent = Just component, selectedComponent = Nothing }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ selectProjectIn SelectProjectIn
        , loadLevelIn LoadLevelIn
        , Draggable.subscriptions DragMsg model.drag
        ]


selectedEntityView : Model -> Html Msg
selectedEntityView model =
    div []
        [ case model.selectedEntity of
            Nothing ->
                text "Select an entity"

            Just entity ->
                div []
                    [ div []
                        [ text <| "id: " ++ (String.fromInt entity.id)
                        ]
                    , div []
                        [ input [ value entity.label, placeholder "label" ] []
                        ]
                    ]
        ]


entityListView : Model -> Html Msg
entityListView model =
    let
        selectedId =
            case model.selectedEntity of
                Nothing ->
                    -1

                Just entity ->
                    entity.id
    in
        ul []
            (List.map
                (\entity ->
                    let
                        style =
                            if selectedId == entity.id then
                                entityListItemSelectedStyles
                            else
                                entityListItemStyles
                    in
                        li
                            [ style, onClick (SelectEntity entity) ]
                            [ text <| String.fromInt entity.id ]
                )
                (model.entities |> Dict.values |> sortEntityList)
            )


entityManagerView : Model -> Html Msg
entityManagerView model =
    div [ entityManagerStyles ]
        [ div []
            [ button [ onClick AddEntity ] [ text "add entity" ]
            ]
        , div [ entityListStyles ]
            [ entityListView model
            ]
        , div [ selectedEntityStyles ]
            [ selectedEntityView model
            ]
        ]


componentsListView : (Component -> Msg) -> List Component -> Maybe String -> Html Msg
componentsListView msg components selected =
    let
        selectedId =
            case selected of
                Nothing ->
                    ""

                Just componentId ->
                    componentId
    in
        div []
            [ ul []
                (List.map
                    (\component ->
                        let
                            style =
                                if selectedId == (toComponentId component) then
                                    componentListItemSelectedStyles
                                else
                                    componentListItemStyles
                        in
                            li
                                [ style, onClick (msg component) ]
                                [ text <| toComponentId component ]
                    )
                    components
                )
            ]


availableComponentsView : Model -> Html Msg
availableComponentsView model =
    let
        queuedComponentId =
            case model.queuedComponent of
                Nothing ->
                    ""

                Just component ->
                    toComponentId component

        available =
            case model.selectedEntity of
                Nothing ->
                    availableComponents

                Just entity ->
                    let
                        used =
                            Dict.keys entity.components
                    in
                        List.filter
                            (\component -> List.member (toComponentId component) used == False)
                            availableComponents
    in
        div []
            [ componentsListView QueueComponent available (Just queuedComponentId)
            ]


paramInput : String -> String -> (String -> a) -> (a -> Component) -> Html Msg
paramInput label_ param converter updater =
    label [ paramStyle ]
        [ div [ paramLabelStyle ]
            [ text <| label_ ++ ": "
            ]
        , input
            [ paramInputStyle
            , onEnter (\value -> UpdateComponent (value |> converter |> updater))
            , onBlur (\value -> UpdateComponent (value |> converter |> updater))
            , value param
            ]
            []
        ]


paramSelect : String -> List String -> String -> (String -> Component) -> Html Msg
paramSelect label_ options param updater =
    label [ paramStyle ]
        [ div [ paramLabelStyle ]
            [ text <| label_ ++ ": "
            ]
        , select
            [ paramInputStyle
            , onInput (\value -> UpdateComponent (updater value))
            , value param
            ]
            (List.map (\opt -> option [] [ text opt ]) options)
        ]


paramInputString : String -> String -> (String -> Component) -> Html Msg
paramInputString label param updater =
    paramInput label param (\val -> val) updater


paramInputInt : String -> Int -> (Int -> Component) -> Html Msg
paramInputInt label param updater =
    paramInput label (String.fromInt param) (toInt param) updater


paramInputFloat : String -> Float -> (Float -> Component) -> Html Msg
paramInputFloat label param updater =
    paramInput label (Numeral.format "0.00" param) (toFloat param) updater


abilityParams : {} -> Html Msg
abilityParams p =
    div []
        []


aggressionParams : { x : Int, y : Int, width : Int, height : Int, duration : Int } -> Html Msg
aggressionParams p =
    div []
        [ paramInputInt "x" p.x (\val -> Aggression { p | x = val })
        , paramInputInt "y" p.y (\val -> Aggression { p | y = val })
        , paramInputInt "width" p.width (\val -> Aggression { p | width = val })
        , paramInputInt "height" p.height (\val -> Aggression { p | height = val })
        , paramInputInt "duration" p.duration (\val -> Aggression { p | duration = val })
        ]


animationParams : {} -> Html Msg
animationParams p =
    div []
        []


containerParams : {} -> Html Msg
containerParams p =
    div []
        []


damageParams : { hitpoints : Int } -> Html Msg
damageParams p =
    div []
        [ paramInputInt "hitpoints" p.hitpoints (\val -> Damage { p | hitpoints = val }) ]


fixtureParams : { x : Int, y : Int } -> Html Msg
fixtureParams p =
    div []
        [ paramInputInt "x" p.x (\val -> Fixture { p | x = val })
        , paramInputInt "y" p.y (\val -> Fixture { p | y = val })
        ]


healthParams : { hitpoints : Int, armor : Int } -> Html Msg
healthParams p =
    div []
        [ paramInputInt "hitpoints" p.hitpoints (\val -> Health { p | hitpoints = val })
        , paramInputInt "armor" p.armor (\val -> Health { p | armor = val })
        ]


platformParams : { fall : Int, initialX : Int, initialY : Int } -> Html Msg
platformParams p =
    div []
        [ paramInputInt "fall" p.fall (\val -> Platform { p | fall = val })
        , paramInputInt "initialX" p.initialX (\val -> Platform { p | initialX = val })
        , paramInputInt "initialY" p.initialY (\val -> Platform { p | initialY = val })
        ]


playerParams : { alias : String, money : Int, lives : Int, documents : Int, checkpoint : Int } -> Html Msg
playerParams p =
    div []
        [ paramInputString "alias" p.alias (\val -> Player { p | alias = val })
        , paramInputInt "money" p.money (\val -> Player { p | money = val })
        , paramInputInt "lives" p.lives (\val -> Player { p | lives = val })
        , paramInputInt "documents" p.documents (\val -> Player { p | documents = val })
        , paramInputInt "checkpoint" p.checkpoint (\val -> Player { p | checkpoint = val })
        ]


positionParams : { x : Int, y : Int } -> Html Msg
positionParams p =
    div []
        [ paramInputInt "x" p.x (\val -> Position { p | x = val })
        , paramInputInt "y" p.y (\val -> Position { p | y = val })
        ]


spriteParams : { asset : String } -> Html Msg
spriteParams p =
    div []
        [ paramInputString "asset" p.asset (\val -> Sprite { p | asset = val })
        ]


waveParams : { type_ : String, x : Int, y : Int, amplitude : Float, frequency : Float } -> Html Msg
waveParams p =
    let
        options =
            [ "circular", "horizontal", "vertical" ]
    in
        div []
            [ paramSelect "type" options p.type_ (\val -> Wave { p | type_ = val })
            , paramInputInt "x" p.x (\val -> Wave { p | x = val })
            , paramInputInt "y" p.y (\val -> Wave { p | y = val })
            , paramInputFloat "amplitude" p.amplitude (\val -> Wave { p | amplitude = val })
            , paramInputFloat "frequency" p.frequency (\val -> Wave { p | frequency = val })
            ]


selectedComponentsView : Entity -> Model -> Html Msg
selectedComponentsView entity model =
    componentsListView SelectComponent (Dict.values entity.components) model.selectedComponent


selectedComponentView : Entity -> Model -> Html Msg
selectedComponentView entity model =
    div []
        [ case model.selectedComponent of
            Nothing ->
                text "Select a component"

            Just componentId ->
                case Dict.get componentId entity.components of
                    Nothing ->
                        text "Undefined component"

                    Just component ->
                        case component of
                            Aggression params ->
                                aggressionParams params

                            Animation params ->
                                animationParams params

                            Container params ->
                                containerParams params

                            Damage params ->
                                damageParams params

                            Fixture params ->
                                fixtureParams params

                            Health params ->
                                healthParams params

                            Platform params ->
                                platformParams params

                            Player params ->
                                playerParams params

                            Position params ->
                                positionParams params

                            Sprite params ->
                                spriteParams params

                            Wave params ->
                                waveParams params

                            _ ->
                                div [] []
        ]


addComponentButton : Model -> Html Msg
addComponentButton model =
    let
        disabledBtn =
            button [ disabled True ] [ text "add" ]
    in
        case model.queuedComponent of
            Nothing ->
                disabledBtn

            Just component ->
                button [ onClick (AddComponent component) ] [ text "add" ]


removeComponentButton : Model -> Html Msg
removeComponentButton model =
    let
        disabledBtn =
            button [ disabled True ] [ text "remove" ]
    in
        case model.selectedComponent of
            Nothing ->
                disabledBtn

            Just componentId ->
                button [ onClick (RemoveComponent componentId) ] [ text "remove" ]


componentManagerView : Model -> Html Msg
componentManagerView model =
    let
        children =
            case model.selectedEntity of
                Nothing ->
                    [ text "Select an entity" ]

                Just entity ->
                    [ div [ availableComponentsStyles ]
                        [ div [ availableComponentsListStyles ]
                            [ availableComponentsView model ]
                        ]
                    , div [ selectedComponentsStyles ]
                        [ div []
                            [ addComponentButton model
                            , removeComponentButton model
                            ]
                        , div [ selectedComponentsListStyles ]
                            [ selectedComponentsView entity model ]
                        , div [ selectedComponentStyles ]
                            [ selectedComponentView entity model ]
                        ]
                    ]
    in
        div [ componentManagerStyles ] children


toolbarView : Model -> Html Msg
toolbarView model =
    div
        [ toolbarStyles ]
        [ div
            []
            [ text
                ("File: "
                    ++ (case
                            model.levelParseError
                        of
                            Nothing ->
                                model.selectedFile

                            Just err ->
                                err
                       )
                )
            ]
        , input
            [ onInput SetLevelId, value (String.fromInt model.levelId) ]
            []
        , input
            [ onInput SetLevelName, value model.levelName ]
            []
        , button
            [ onClick SaveLevel ]
            [ text "save level" ]
        , button
            [ onClick SelectProjectOut ]
            [ text "select project" ]
        ]


hasJson : TreeNode -> Bool
hasJson node =
    case node of
        Directory directory ->
            List.any hasJson directory.children

        File file ->
            file.extension == ".json"


nodeView : Model -> Int -> TreeNode -> Html Msg
nodeView model depth node =
    div []
        [ case node of
            Directory directory ->
                if List.any hasJson directory.children then
                    ul []
                        [ li []
                            [ div [ treeDirectoryItemStyles depth ] [ text directory.name ]
                            , div [] (List.map (nodeView model (depth + 1)) directory.children)
                            ]
                        ]
                else
                    text ""

            File file ->
                if file.extension == ".json" then
                    let
                        style =
                            if file.path == model.selectedFile then
                                treeFileItemSelectedStyles depth
                            else
                                treeFileItemStyles depth
                    in
                        li
                            [ style
                            , onClick (LoadLevelOut file.path)
                            ]
                            [ text file.name ]
                else
                    text ""
        ]


treeView : Model -> Html Msg
treeView model =
    div [ treeStyles ]
        [ case model.tree of
            Nothing ->
                div [] []

            Just node ->
                nodeView model 0 node
        ]


sceneView : Model -> Html Msg
sceneView model =
    div [ sceneStyles ]
        [ div []
            (List.map
                (\entity ->
                    div
                        [ draggableStyles model.position
                        , fromUnstyled (Draggable.mouseTrigger () DragMsg)
                        ]
                        [ text "foo" ]
                )
                (Dict.values model.entities)
            )
        ]


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ toolbarView model
            , treeView model
            , entityManagerView model
            , componentManagerView model
            , sceneView model
            ]
        ]
