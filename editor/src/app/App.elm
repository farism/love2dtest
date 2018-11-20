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
import Html.Styled.Attributes exposing (disabled, fromUnstyled, placeholder, selected, value)
import Html.Styled exposing (Html, button, div, input, label, li, option, select, text, ul, toUnstyled)
import Numeral
import Types exposing (..)
import Components exposing (..)
import Serializers exposing (..)
import Styles exposing (..)


port selectProjectOut : () -> Cmd msg


port selectProjectIn : (String -> msg) -> Sub msg


port loadLevelOut : String -> Cmd msg


port loadLevelIn : (( String, String ) -> msg) -> Sub msg


port saveLevelOut : ( String, JD.Value ) -> Cmd msg


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , view = view >> toUnstyled
        , update = update
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


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Draggable.subscriptions DragMsg model.drag
        , selectProjectIn SelectProjectIn
        , loadLevelIn LoadLevelIn
        ]


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

                        foo =
                            Debug.log "level" level
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
            ( { model | levelId = toInt id }, Cmd.none )

        SetLevelName name ->
            ( { model | levelName = name }, Cmd.none )

        SelectEntity entity ->
            ( { model | selectedEntity = Just entity.id, selectedComponent = Nothing }, Cmd.none )

        AddEntity ->
            let
                nextId =
                    model.nextId + 1

                entity =
                    Entity nextId "" { x = 0, y = 0 } Dict.empty

                entities =
                    Dict.insert (String.fromInt entity.id) entity model.entities
            in
                ( { model | nextId = nextId, entities = entities, selectedEntity = Just entity.id }, Cmd.none )

        RemoveEntity ->
            let
                entities =
                    case selectedEntity model of
                        Nothing ->
                            model.entities

                        Just entity ->
                            Dict.remove (String.fromInt entity.id) model.entities
            in
                ( { model | selectedEntity = Nothing, entities = entities }, Cmd.none )

        SelectComponent component ->
            ( { model | selectedComponent = Just component.id }, Cmd.none )

        AddComponent component ->
            let
                newModel =
                    updateComponents
                        (\components -> Dict.insert component.id component components)
                        model
            in
                ( { newModel | queuedComponent = Nothing, selectedComponent = Just component.id }, Cmd.none )

        RemoveComponent id ->
            let
                newModel =
                    updateComponents
                        (\components -> Dict.remove id components)
                        model
            in
                ( newModel, Cmd.none )

        UpdateComponent id key param value ->
            let
                newModel =
                    updateComponents (updateComponent id key param value) model
            in
                ( newModel, Cmd.none )

        QueueComponent component ->
            ( { model | queuedComponent = Just component, selectedComponent = Nothing }, Cmd.none )


selectedEntity : Model -> Maybe Entity
selectedEntity model =
    case model.selectedEntity of
        Nothing ->
            Nothing

        Just id ->
            case Dict.get (String.fromInt id) model.entities of
                Nothing ->
                    Nothing

                Just entity ->
                    Just entity


selectedComponents : Model -> Dict String Component
selectedComponents model =
    case model.selectedEntity of
        Nothing ->
            Dict.empty

        Just id ->
            case Dict.get (String.fromInt id) model.entities of
                Nothing ->
                    Dict.empty

                Just entity ->
                    entity.components


updateComponents : (Dict String Component -> Dict String Component) -> Model -> Model
updateComponents fn model =
    let
        entities =
            (case selectedEntity model of
                Nothing ->
                    model.entities

                Just entity ->
                    let
                        newEntity =
                            { entity | components = fn entity.components }

                        newEntities =
                            Dict.insert (String.fromInt entity.id) newEntity model.entities
                    in
                        newEntities
            )
    in
        { model | entities = entities }


updateComponent : String -> String -> Param -> String -> Dict String Component -> Dict String Component
updateComponent id key param value components =
    case Dict.get id components of
        Nothing ->
            components

        Just component ->
            let
                newValue =
                    { param | value = validate param value }

                params =
                    Dict.insert key newValue component.params

                newComponent =
                    { component | params = params }
            in
                Dict.insert id newComponent components


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


sortParamList : List ( String, Param ) -> List ( String, Param )
sortParamList list =
    List.sortWith
        (\( _, a ) ( _, b ) -> compare a.order b.order)
        list


toInt : String -> Int
toInt value =
    if value == "" then
        0
    else
        case String.toInt value of
            Nothing ->
                0

            Just int ->
                int


toFloat : String -> Float
toFloat value =
    if value == "" then
        0.0
    else
        case String.toFloat value of
            Nothing ->
                0.0

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


selectedEntityView : Model -> Html Msg
selectedEntityView model =
    let
        entity =
            selectedEntity model
    in
        div []
            [ case entity of
                Nothing ->
                    text "Select an entity"

                Just e ->
                    div []
                        [ div []
                            [ text <| "id: " ++ (String.fromInt e.id)
                            ]
                        , div []
                            [ input [ value e.label, placeholder "label" ] []
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

                Just id ->
                    id
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


componentsListView : (Component -> Msg) -> List Component -> Html Msg
componentsListView msg components =
    div []
        [ ul []
            (components
                |> List.map
                    (\component ->
                        li
                            [ (componentListItemStyles False)
                            , onClick (msg component)
                            ]
                            [ text component.id ]
                    )
            )
        ]


availableComponentsView : Model -> Html Msg
availableComponentsView model =
    case model.selectedEntity of
        Nothing ->
            div [] []

        Just id ->
            let
                components =
                    selectedComponents model

                used =
                    Dict.keys components

                available =
                    List.filter
                        (\component -> List.member component.id used == False)
                        availableComponents
            in
                div []
                    [ componentsListView QueueComponent available
                    ]


validate : Param -> String -> String
validate param value =
    case param.paramType of
        Int ->
            case String.toInt value of
                Nothing ->
                    param.value

                Just _ ->
                    value

        Float ->
            case String.toFloat value of
                Nothing ->
                    param.value

                Just _ ->
                    value

        _ ->
            value


formatParam : Param -> String
formatParam param =
    case param.paramType of
        Float ->
            Numeral.format "0.00" (toFloat param.value)

        Int ->
            Numeral.format "0" (toFloat param.value)

        _ ->
            param.value


paramInput : String -> String -> Param -> Html Msg
paramInput component key param =
    label [ paramStyle ]
        [ div [ paramLabelStyle ]
            [ text (key ++ ": ")
            ]
        , input
            [ paramInputStyle
            , onEnter (\value -> UpdateComponent component key param value)
            , onBlur (\value -> UpdateComponent component key param value)
            , value (formatParam param)
            ]
            []
        ]


paramSelect : String -> String -> List String -> Param -> Html Msg
paramSelect component key options param =
    label [ paramStyle ]
        [ div [ paramLabelStyle ]
            [ text (key ++ ": ")
            ]
        , select
            [ paramInputStyle
            , onInput (\value -> UpdateComponent component key param value)
            , value param.value
            ]
            (List.map (\opt -> option [ selected (opt == param.value) ] [ text opt ]) options)
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
                button [ onClick (AddComponent component) ]
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

            Just id ->
                button [ onClick (RemoveComponent id) ] [ text "remove" ]


paramsView : String -> Dict String Param -> Html Msg
paramsView id params =
    ul []
        (params
            |> Dict.toList
            |> sortParamList
            |> List.map
                (\( key, param ) ->
                    li []
                        [ label []
                            [ case param.options of
                                Nothing ->
                                    paramInput id key param

                                Just opts ->
                                    paramSelect id key opts param
                            ]
                        ]
                )
        )


selectedComponentView : Model -> Html Msg
selectedComponentView model =
    div []
        [ case model.selectedComponent of
            Nothing ->
                text "Select a component"

            Just id ->
                let
                    components =
                        selectedComponents model

                    component =
                        Dict.get id components
                in
                    case component of
                        Nothing ->
                            text "Entity does not contain component"

                        Just c ->
                            paramsView id c.params
        ]


componentManagerView : Model -> Html Msg
componentManagerView model =
    let
        children =
            case model.selectedEntity of
                Nothing ->
                    [ text "Select an entity" ]

                Just _ ->
                    let
                        components =
                            selectedComponents model

                        keys =
                            Dict.keys components

                        selected =
                            Dict.values components

                        available =
                            List.filter
                                (\component -> List.member component.id keys == False)
                                availableComponents
                    in
                        [ div [ availableComponentsStyles ]
                            [ div [ availableComponentsListStyles ]
                                [ componentsListView QueueComponent available
                                ]
                            ]
                        , div [ selectedComponentsStyles ]
                            [ div []
                                [ addComponentButton model
                                , removeComponentButton model
                                ]
                            , div [ selectedComponentsListStyles ]
                                [ componentsListView SelectComponent selected
                                ]
                            , div [ selectedComponentStyles ]
                                [ selectedComponentView model
                                ]
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
                    li
                        [ treeFileItemStyles (file.path == model.selectedFile) depth
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
