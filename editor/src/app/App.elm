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

        SelectEntity entity ->
            ( { model | selectedEntity = Just entity, selectedComponent = Nothing }, Cmd.none )

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

        SelectComponent component ->
            ( { model | selectedComponent = Just component }, Cmd.none )

        QueueComponent component ->
            ( { model | queuedComponent = Just component }, Cmd.none )


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
                        li [] []
                     -- let
                     --     style =
                     --         if selectedId == (toComponentId component) then
                     --             componentListItemSelectedStyles
                     --         else
                     --             componentListItemStyles
                     -- in
                     --     li
                     --         [ style, onClick (msg component) ]
                     --         [ text <| toComponentId component ]
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
                    component

        available =
            case model.selectedEntity of
                Nothing ->
                    availableComponents

                Just entity ->
                    let
                        used =
                            Dict.keys entity.components
                    in
                        availableComponents
                            |> Dict.toList
                            |> List.filter
                                (\( component, params ) -> List.member component used == False)
    in
        div []
            [ componentsListView QueueComponent available (Just queuedComponentId)
            ]


availableComponents =
    Dict.fromList
        [ ( "player"
          , Dict.fromList
                [ ( "alias", StringParam "" )
                , ( "money", IntParam 0 )
                , ( "lives", IntParam 0 )
                , ( "documents", IntParam 0 )
                , ( "checkpoint", IntParam 0 )
                ]
          )
        , ( "position"
          , Dict.fromList
                [ ( "x", IntParam 0 )
                , ( "y", IntParam 0 )
                ]
          )
        ]



-- availableComponentsView : Model -> Html Msg
-- availableComponentsView model =
--     div []
--         (List.map
--             (\component ->
--                 div [] [ text component ]
--             )
--             (Dict.keys availableComponents)
--         )


paramInput : String -> String -> (String -> a) -> (a -> Component) -> Html Msg
paramInput label_ param converter updater =
    label [ paramStyle ]
        [ div [ paramLabelStyle ]
            [ text <| label_ ++ ": "
            ]
        , input
            [ paramInputStyle
              -- , onEnter (\value -> UpdateComponent (value |> converter |> updater))
              -- , onBlur (\value -> UpdateComponent (value |> converter |> updater))
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
              -- , onInput (\value -> UpdateComponent (updater value))
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



-- selectedComponentsView : Entity -> Model -> Html Msg
-- selectedComponentsView entity model =
--     componentsListView SelectComponent (Dict.values entity.components) model.selectedComponent


selectedComponentView : Entity -> Model -> Html Msg
selectedComponentView entity model =
    div []
        [ case model.selectedComponent of
            Nothing ->
                text "Select a component"

            Just componentId ->
                text "selected"
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

            Just ( component, params ) ->
                button [ onClick (AddComponent ( component, params )) ]
                    [ text "add" ]


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
                -- button [ onClick (RemoveComponent componentId) ] [ text "remove" ]
                button [] [ text "remove" ]


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
                            [ availableComponentsView model
                            ]
                        ]
                    , div [ selectedComponentsStyles ]
                        [ div []
                            [ addComponentButton model
                            , removeComponentButton model
                            ]
                        , div [ selectedComponentsListStyles ]
                            [-- selectedComponentsView entity model
                            ]
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
