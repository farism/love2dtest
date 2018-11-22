port module App exposing (..)

import Maybe
import Browser
import Browser.Dom
import Dict exposing (Dict)
import Draggable exposing (Delta)
import Draggable.Events exposing (onDragBy)
import Html.Styled.Events exposing (keyCode, on, onClick, onInput, onMouseDown, targetValue)
import Html.Styled.Attributes exposing (disabled, fromUnstyled, placeholder, selected, value)
import Html.Styled exposing (Html, button, div, input, label, li, option, select, text, ul, toUnstyled)
import Json.Decode as JD
import Numeral
import UndoList exposing (UndoList)
import Components exposing (..)
import Helpers exposing (..)
import Serializers exposing (..)
import Styles exposing (..)
import Types exposing (..)


port selectProjectOut : () -> Cmd msg


port selectProjectIn : (String -> msg) -> Sub msg


port loadLevelOut : String -> Cmd msg


port loadLevelIn : (( String, String ) -> msg) -> Sub msg


port saveLevelOut : ( String, JD.Value ) -> Cmd msg


main : Program Flags UndoModel Msg
main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , view = toUnstyled << (UndoList.view view)
        , update = updateWithUndo
        }


init : Flags -> ( UndoModel, Cmd Msg )
init flags =
    ( initialModel, Cmd.none )


initialModel : UndoModel
initialModel =
    UndoList.fresh
        { tree = Nothing
        , selectedFile = ""
        , selectedEntity = Nothing
        , selectedComponent = Nothing
        , queuedComponent = Nothing
        , levelParseError = Nothing
        , levelId = 0
        , levelName = ""
        , entities = Dict.empty
        , nextId = 0
        }


subscriptions : UndoModel -> Sub Msg
subscriptions model =
    let
        draggableSubscription =
            case selectedEntity model.present of
                Nothing ->
                    []

                Just entity ->
                    [ Draggable.subscriptions (DragMsg entity) entity.drag
                    ]
    in
        Sub.batch
            (draggableSubscription
                ++ [ selectProjectIn SelectProjectIn
                   , loadLevelIn LoadLevelIn
                   ]
            )


updateWithUndo : Msg -> UndoModel -> ( UndoModel, Cmd Msg )
updateWithUndo msg model =
    case msg of
        Undo ->
            ( UndoList.undo model, Cmd.none )

        Redo ->
            ( UndoList.redo model, Cmd.none )

        _ ->
            let
                ( newModel, cmds ) =
                    update msg model.present
            in
                ( UndoList.new newModel model, cmds )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DragMsg entity dragMsg ->
            let
                newModel =
                    { model | selectedEntity = Just entity.id }
            in
                case selectedEntity newModel of
                    Nothing ->
                        ( newModel, Cmd.none )

                    Just e ->
                        let
                            ( newEntity, cmds ) =
                                Draggable.update dragConfig dragMsg e

                            entities =
                                Dict.insert (String.fromInt entity.id) newEntity newModel.entities
                        in
                            ( { newModel | entities = entities }, cmds )

        OnDragBy ( dx, dy ) ->
            case selectedEntity model of
                Nothing ->
                    ( model, Cmd.none )

                Just entity ->
                    let
                        dragpoint =
                            Vertex (entity.dragpoint.x + dx) (entity.dragpoint.y + dy)

                        newEntity =
                            { entity | dragpoint = dragpoint }

                        entities =
                            Dict.insert (String.fromInt entity.id) newEntity model.entities
                    in
                        ( { model | entities = entities }, Cmd.none )

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
                    ( { model | levelParseError = Just "Invalid file format" }, Cmd.none )

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
            ( { model | levelId = strToInt id }, Cmd.none )

        SetLevelName name ->
            ( { model | levelName = name }, Cmd.none )

        SelectEntity entity ->
            ( { model | selectedEntity = Just entity.id, selectedComponent = Nothing }, Cmd.none )

        AddEntity ->
            let
                nextId =
                    model.nextId + 1

                entity =
                    Entity nextId "" Dict.empty { x = 0, y = 0 } Draggable.init

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

        UpdateParam component key param value ->
            let
                newModel =
                    updateComponents
                        (\components ->
                            (Dict.map
                                (\k v ->
                                    let
                                        newParam =
                                            { param | value = validateParam param value }
                                    in
                                        if k == component then
                                            { v | params = Dict.insert key newParam v.params }
                                        else
                                            v
                                )
                                components
                            )
                        )
                        model
            in
                ( newModel, Cmd.none )

        QueueComponent component ->
            ( { model | queuedComponent = Just component, selectedComponent = Nothing }, Cmd.none )

        _ ->
            ( model, Cmd.none )


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


selectedComponent : Model -> Maybe Component
selectedComponent model =
    case model.selectedComponent of
        Nothing ->
            Nothing

        Just id ->
            Dict.get id (selectedComponents model)


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



-- let
--   case path of
--     head::tail
--     newValue =
--         { param | value = validateParam param value }
--     params =
--         Dict.insert path newValue component.params
--     newComponent =
--         { component | params = params }
-- in
--     Dict.insert id newComponent components


dragConfig : Draggable.Config () Msg
dragConfig =
    Draggable.basicConfig OnDragBy


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


onBlur : (String -> Msg) -> Html.Styled.Attribute Msg
onBlur handler =
    on "blur" (JD.map handler targetValue)


onEnter : (String -> msg) -> Html.Styled.Attribute msg
onEnter msg =
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
                (\_ value -> msg value)
                decodeEnter
                targetValue


hasJson : TreeNode -> Bool
hasJson node =
    case node of
        Directory directory ->
            List.any hasJson directory.children

        File file ->
            file.extension == ".json"


formatParam : Param -> String
formatParam param =
    case param.value of
        StringValue value ->
            value

        IntValue value ->
            Numeral.format "0" (toFloat value)

        FloatValue value ->
            Numeral.format "0.00" value

        _ ->
            Debug.toString param.value


validateParam : Param -> String -> ParamValue
validateParam param newValue =
    case param.value of
        IntValue oldValue ->
            if newValue == "" then
                IntValue 0
            else
                case String.toInt newValue of
                    Nothing ->
                        IntValue oldValue

                    Just value ->
                        IntValue value

        FloatValue oldValue ->
            if newValue == "" then
                FloatValue 0
            else
                case String.toFloat newValue of
                    Nothing ->
                        FloatValue oldValue

                    Just value ->
                        FloatValue value

        _ ->
            StringValue newValue


inputView : String -> String -> (String -> Msg) -> Html Msg
inputView key val fn =
    label [ paramStyle ]
        [ div [ paramLabelStyle ] [ text (key ++ ": ") ]
        , input [ paramInputStyle, onEnter fn, onBlur fn, value val ] []
        ]


selectView : String -> String -> List String -> (String -> Msg) -> Html Msg
selectView key val options fn =
    label [ paramStyle ]
        [ div [ paramLabelStyle ] [ text (key ++ ": ") ]
        , select
            [ paramInputStyle
            , onInput fn
            , value val
            ]
            (List.map
                (\opt -> option [ selected (opt == val) ] [ text opt ])
                options
            )
        ]


bodyView : Body -> Html Msg
bodyView body =
    div []
        [ div [] [ text "body" ]
        , selectView
            "type"
            (fromBodyType body.bodyType)
            bodyTypes
            (\value -> UpdateBody { body | bodyType = toBodyType value })
        , inputView
            "x"
            (Debug.toString body.x)
            (\value -> UpdateBody { body | x = (strToFloat value) })
        , inputView
            "y"
            (Debug.toString body.y)
            (\value -> UpdateBody { body | y = (strToFloat value) })
        ]


shapeView : Shape -> Html Msg
shapeView shape =
    div []
        (case shape of
            Rectangle rectangle ->
                []

            Circle circle ->
                []

            _ ->
                []
        )


paramFieldView : String -> String -> Param -> Html Msg
paramFieldView component key param =
    case param.options of
        Nothing ->
            case param.value of
                StringValue str ->
                    inputView key str (UpdateParam component key param)

                IntValue int ->
                    inputView key (Debug.toString int) (UpdateParam component key param)

                FloatValue float ->
                    inputView key (Debug.toString float) (UpdateParam component key param)

                BodyValue body ->
                    bodyView body

                ShapeValue shape ->
                    shapeView shape

                _ ->
                    text ""

        Just opts ->
            case param.value of
                StringValue value ->
                    selectView key value opts (UpdateParam component key param)

                _ ->
                    text ""


paramsView : String -> Dict String Param -> Html Msg
paramsView component params =
    ul []
        (params
            |> Dict.toList
            |> sortParamList
            |> List.map
                (\( key, param ) ->
                    li []
                        [ label []
                            [ paramFieldView component key param
                            ]
                        ]
                )
        )


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


addComponentButton : Model -> Html Msg
addComponentButton model =
    case model.queuedComponent of
        Nothing ->
            button [ disabled True ] [ text "add" ]

        Just component ->
            button [ onClick (AddComponent component) ]
                [ text "add" ]


removeComponentButton : Model -> Html Msg
removeComponentButton model =
    case model.selectedComponent of
        Nothing ->
            button [ disabled True ] [ text "remove" ]

        Just id ->
            button [ onClick (RemoveComponent id) ] [ text "remove" ]


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


componentsListView : (Component -> Msg) -> String -> List Component -> Html Msg
componentsListView msg selected components =
    div []
        [ ul []
            (components
                |> List.sortBy .id
                |> List.map
                    (\component ->
                        li
                            [ componentListItemStyles (selected == component.id)
                            , onClick (msg component)
                            ]
                            [ text component.id ]
                    )
            )
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

                        queuedId =
                            case model.queuedComponent of
                                Nothing ->
                                    ""

                                Just component ->
                                    component.id

                        selectedId =
                            case model.selectedComponent of
                                Nothing ->
                                    ""

                                Just id ->
                                    id
                    in
                        [ div [ availableComponentsStyles ]
                            [ div [ availableComponentsListStyles ]
                                [ componentsListView QueueComponent queuedId available
                                ]
                            ]
                        , div [ selectedComponentsStyles ]
                            [ div []
                                [ addComponentButton model
                                , removeComponentButton model
                                ]
                            , div [ selectedComponentsListStyles ]
                                [ componentsListView SelectComponent selectedId selected
                                ]
                            , div [ selectedComponentStyles ]
                                [ selectedComponentView model
                                ]
                            ]
                        ]
    in
        div [ componentManagerStyles ] children


parseErrorView : Model -> String
parseErrorView model =
    case model.levelParseError of
        Nothing ->
            model.selectedFile

        Just err ->
            err


toolbarView : Model -> Html Msg
toolbarView model =
    div
        [ toolbarStyles ]
        [ button [ onClick SaveLevel ] [ text "save level" ]
        , input [ onInput SetLevelId, value (String.fromInt model.levelId) ] []
        , input [ onInput SetLevelName, value model.levelName ] []
        , button [ onClick Undo ] [ text "undo" ]
        , button [ onClick Redo ] [ text "redo" ]
        , div [] [ text ("File: " ++ (parseErrorView model)) ]
        ]


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
                text "Select a project"

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
                        [ draggableStyles entity.dragpoint
                        , fromUnstyled (Draggable.mouseTrigger () (DragMsg entity))
                        ]
                        []
                )
                (Dict.values model.entities)
            )
        ]


view : Model -> Html Msg
view model =
    div []
        (case model.tree of
            Nothing ->
                [ button
                    [ onClick SelectProjectOut ]
                    [ text "select project" ]
                ]

            Just tree ->
                [ toolbarView model
                , treeView model
                , entityManagerView model
                , componentManagerView model
                , sceneView model
                ]
        )
