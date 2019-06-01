module App exposing (..)

import Body exposing (Body, BodyMsg(..))
import Browser
import Browser.Dom
import Component exposing (Component)
import Data exposing (availableComponents)
import Dict exposing (Dict)
import Draggable exposing (Delta)
import Draggable.Events exposing (onDragBy)
import Entity exposing (Entity)
import Fixture exposing (Fixture, FixtureMsg(..))
import FontAwesome.Attributes as Icon
import FontAwesome.Solid as Icon
import Helpers exposing (commaDelimited, onBlur, onEnter, pathKey)
import Html.Styled exposing (Attribute, Html, div, label, li, option, span, text, ul, toUnstyled)
import Html.Styled.Attributes exposing (checked, css, disabled, fromUnstyled, placeholder, selected, title, value)
import Html.Styled.Events exposing (onClick, onInput)
import Json.Decode as JD
import List.Extra
import Maybe
import Numeral
import Param exposing (Param, ParamValue(..))
import Ports
import Scene exposing (Scene, SceneMsg(..))
import Shape exposing (Shape(..), ShapeMsg(..))
import Styles exposing (..)
import Tree exposing (TreeNode(..))
import Widgets exposing (button, checkbox, hr, input, select)


type alias Flags =
    {}


type Msg
    = CloseScene Int
    | LoadFileIn ( String, String )
    | LoadFileOut String
    | SaveFileOut
    | SelectProjectPathIn String
    | SelectProjectPathOut
    | SelectSceneIndex Int
    | SceneMsg SceneMsg


type alias Model =
    { sceneParseError : Maybe String
    , scenes : List Scene
    , selectedSceneIndex : Maybe Int
    , tree : Maybe TreeNode
    }


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
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    { sceneParseError = Nothing
    , scenes = [ Scene.init ]
    , selectedSceneIndex = Just 0
    , tree = Nothing
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    let
        sceneSubscriptions =
            case selectedScene model of
                Nothing ->
                    []

                Just scene ->
                    Scene.subscriptions SceneMsg scene
    in
        Sub.batch
            (sceneSubscriptions
                ++ [ Ports.selectProjectPathIn SelectProjectPathIn
                   , Ports.loadFileIn LoadFileIn
                   ]
            )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CloseScene index ->
            let
                scenes =
                    List.Extra.removeAt index model.scenes
            in
                ( ({ model | scenes = scenes }), Cmd.none )

        LoadFileIn ( file, json ) ->
            case Scene.decode file json of
                Err err ->
                    ( { model | sceneParseError = Just "Invalid file format" }, Cmd.none )

                Ok scene ->
                    let
                        lastId =
                            Scene.lastEntityId (Dict.values scene.entities)

                        newScene =
                            { scene | file = Just file, selectedEntity = Just lastId, nextId = lastId + 1 }

                        scenes =
                            (model.scenes ++ [ newScene ])
                    in
                        ( { model
                            | sceneParseError = Nothing
                            , selectedSceneIndex = Just ((List.length scenes) - 1)
                            , scenes = scenes
                          }
                        , Cmd.none
                        )

        LoadFileOut file ->
            case List.Extra.findIndex (\scene -> scene.file == Just file) model.scenes of
                Nothing ->
                    ( model, Ports.loadFileOut (file) )

                Just index ->
                    ( { model | selectedSceneIndex = Just index }, Cmd.none )

        SaveFileOut ->
            case selectedScene model of
                Nothing ->
                    ( model, Cmd.none )

                Just scene ->
                    ( model, Ports.saveFileOut ( "", Scene.encode scene ) )

        SceneMsg sceneMsg ->
            case selectedScene model of
                Nothing ->
                    ( model, Cmd.none )

                Just scene ->
                    let
                        ( newScene, cmds ) =
                            Scene.update sceneMsg scene

                        scenes =
                            List.Extra.setAt (selectedSceneIndex model) newScene model.scenes
                    in
                        ( { model | scenes = scenes }, Cmd.map SceneMsg cmds )

        SelectProjectPathIn json ->
            case Tree.decode json of
                Err err ->
                    ( model, Cmd.none )

                Ok tree ->
                    ( { model | tree = Just tree }, Cmd.none )

        SelectProjectPathOut ->
            ( model, Ports.selectProjectPathOut () )

        SelectSceneIndex index ->
            ( { model | selectedSceneIndex = Just index }, Cmd.none )


selectedSceneIndex : Model -> Int
selectedSceneIndex model =
    case model.selectedSceneIndex of
        Nothing ->
            -1

        Just index ->
            index


selectedScene : Model -> Maybe Scene
selectedScene model =
    List.Extra.getAt (selectedSceneIndex model) model.scenes


sortEntities : List Entity -> List Entity
sortEntities list =
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


sortParams : List ( String, Param ) -> List ( String, Param )
sortParams list =
    List.sortWith
        (\( _, a ) ( _, b ) -> compare a.order b.order)
        list


lastPathKey : List ( String, Param ) -> String
lastPathKey list =
    pathKey (List.map (\( key, _ ) -> key) list)


componentLabelView : String -> List (Html Msg) -> Html Msg
componentLabelView string children =
    label [ componentParamInputStyles ]
        ([ span [ css [ labelStyles ] ] [ text string ]
         ]
            ++ children
        )


componentCheckboxView : (Bool -> SceneMsg) -> Bool -> Html Msg
componentCheckboxView msg val =
    checkbox
        [ onClick (SceneMsg (msg (not val)))
        , checked val
        ]
        []


componentInputView : (String -> SceneMsg) -> String -> Html Msg
componentInputView msg val =
    input
        [ css [ inputNarrowStyles ]
        , value val
        , onBlur (SceneMsg << msg)
        , onEnter (SceneMsg << msg)
        ]
        []


componentSelectView : List String -> (String -> SceneMsg) -> String -> Html Msg
componentSelectView options msg val =
    select
        [ css [ inputNarrowStyles ]
        , onInput (SceneMsg << msg)
        , value val
        ]
        (List.map
            (\opt -> option [ selected (opt == val) ] [ text opt ])
            options
        )


paramInputView : List ( String, Param ) -> String -> Html Msg
paramInputView path val =
    componentLabelView (lastPathKey path)
        [ componentInputView (UpdateParam path) val
        ]


paramSelectView : List String -> List ( String, Param ) -> String -> Html Msg
paramSelectView options path val =
    label [ componentParamInputStyles ]
        [ span [ css [ labelStyles ] ] [ text (lastPathKey path) ]
        , componentSelectView options (UpdateParam path) val
        ]


paramFieldView : List ( String, Param ) -> Html Msg
paramFieldView path =
    case List.Extra.last path of
        Nothing ->
            text ""

        Just ( key, param ) ->
            case param.value of
                Bool value ->
                    div [] []

                Category value ->
                    paramInputView path (commaDelimited value)

                Dict value ->
                    div []
                        [ text key
                        , paramsView path value
                        ]

                Float value ->
                    paramInputView path (String.fromFloat value)

                Int value ->
                    paramInputView path (String.fromInt value)

                Mask value ->
                    paramInputView path (commaDelimited value)

                Select options value ->
                    paramSelectView options path value

                String value ->
                    paramInputView path value

                _ ->
                    text ""


paramsView : List ( String, Param ) -> Dict String Param -> Html Msg
paramsView path params =
    ul []
        (params
            |> Dict.toList
            |> sortParams
            |> List.map
                (\item ->
                    li []
                        [ paramFieldView (path ++ [ item ]) ]
                )
        )


fixtureCheckboxView : (Bool -> FixtureMsg) -> String -> Bool -> Html Msg
fixtureCheckboxView msg key val =
    componentLabelView key
        [ componentCheckboxView (FixtureMsg << msg) val
        ]


fixtureInputView : (String -> FixtureMsg) -> String -> String -> Html Msg
fixtureInputView msg key val =
    componentLabelView key
        [ componentInputView (FixtureMsg << msg) val
        ]


fixtureSelectView : List String -> (String -> FixtureMsg) -> String -> String -> Html Msg
fixtureSelectView options msg key val =
    componentLabelView key
        [ componentSelectView options (FixtureMsg << msg) val
        ]


fixtureBodyView : Body -> Html Msg
fixtureBodyView body =
    div []
        [ fixtureSelectView Body.bodyTypes (BodyMsg << SetBodyType) "bodyType" (Body.typeToStr body.bodyType)
        , fixtureInputView (BodyMsg << SetBodyCategory) "category" (commaDelimited body.category)
        , fixtureInputView (BodyMsg << SetBodyMask) "mask" (commaDelimited body.mask)
        , fixtureInputView (BodyMsg << SetBodyX) "x" (String.fromFloat body.x)
        , fixtureInputView (BodyMsg << SetBodyY) "y" (String.fromFloat body.y)
        ]


fixtureShapeView : Shape -> Html Msg
fixtureShapeView shape =
    div []
        [ fixtureSelectView Shape.shapeTypes (ShapeMsg << Replace) "shapeType" (Shape.typeToStr shape)
        , case shape of
            Chain { loop, vertices } ->
                div []
                    [ fixtureCheckboxView (ShapeMsg << SetChainLoop) "loop" loop ]

            Circle { radius } ->
                div []
                    [ fixtureInputView (ShapeMsg << SetCircleRadius) "radius" (String.fromInt radius)
                    ]

            Edge { vertex1, vertex2 } ->
                div []
                    []

            Polygon { vertices } ->
                div []
                    []

            Rectangle { width, height } ->
                div []
                    [ fixtureInputView (ShapeMsg << SetRectangleWidth) "width" (String.fromInt width)
                    , fixtureInputView (ShapeMsg << SetRectangleHeight) "height" (String.fromInt height)
                    ]
        ]


fixtureView : Maybe Fixture -> Html Msg
fixtureView fixture =
    case fixture of
        Nothing ->
            div [] []

        Just { density, friction, body, shape } ->
            div []
                [ fixtureInputView SetDensity "density" (String.fromFloat density)
                , fixtureInputView SetFriction "friction" (String.fromFloat friction)
                , fixtureBodyView body
                , fixtureShapeView shape
                ]


entityLabel : Entity -> String
entityLabel entity =
    let
        label =
            if entity.label == "" then
                ""
            else
                " - " ++ entity.label
    in
        String.fromInt entity.id ++ label


entityListView : Scene -> Html Msg
entityListView scene =
    let
        selectedId =
            Scene.selectedEntityId scene
    in
        ul []
            (List.map
                (\entity ->
                    li
                        [ entityListItemStyles (selectedId == entity.id)
                        , onClick (SceneMsg (SelectEntity entity.id))
                        ]
                        [ text (entityLabel entity) ]
                )
                (scene.entities |> Dict.values |> sortEntities)
            )


selectedEntityView : Scene -> Html Msg
selectedEntityView scene =
    case Scene.selectedEntity scene of
        Nothing ->
            text "Select an entity"

        Just entity ->
            input
                [ entityInputStyles
                , value entity.label
                , placeholder "Label"
                , onBlur (SceneMsg << SetEntityLabel entity)
                , onEnter (SceneMsg << SetEntityLabel entity)
                ]
                []


addEntityButton : Html Msg
addEntityButton =
    button [ onClick (SceneMsg AddEntity), title "Add Entity" ]
        [ Html.Styled.fromUnstyled (Icon.plus []) ]


removeEntityButton : Maybe Int -> Html Msg
removeEntityButton selected =
    let
        attributes =
            (case selected of
                Nothing ->
                    [ disabled True ]

                Just id ->
                    [ onClick (SceneMsg (RemoveEntity id)) ]
            )
    in
        button (attributes ++ [ title "Remove Entity" ])
            [ Html.Styled.fromUnstyled (Icon.minus []) ]


entityManagerView : Model -> Html Msg
entityManagerView model =
    div [ entityManagerStyles ]
        [ div [ panelTitleStyles ] [ text "Entities" ]
        , hr
        , div []
            (case selectedScene model of
                Nothing ->
                    [ div [] [ text "Select a scene" ] ]

                Just scene ->
                    [ div []
                        [ addEntityButton
                        , removeEntityButton scene.selectedEntity
                        , hr
                        ]
                    , div [ selectedEntityStyles ]
                        [ selectedEntityView scene
                        ]
                    , hr
                    , div [ entityListStyles ]
                        [ entityListView scene
                        ]
                    ]
            )
        ]


addComponentButton : Maybe Component -> Html Msg
addComponentButton queued =
    let
        attributes =
            (case queued of
                Nothing ->
                    [ disabled True ]

                Just component ->
                    [ onClick (SceneMsg (AddComponent component)) ]
            )
    in
        button (attributes ++ [ title "Add Component" ])
            [ Html.Styled.fromUnstyled (Icon.plus []) ]


removeComponentButton : Maybe String -> Html Msg
removeComponentButton selected =
    let
        attributes =
            (case selected of
                Nothing ->
                    [ disabled True ]

                Just id ->
                    [ onClick (SceneMsg (RemoveComponent id)) ]
            )
    in
        button (attributes ++ [ title "Remove Component" ])
            [ Html.Styled.fromUnstyled (Icon.minus []) ]


selectedComponentView : Scene -> Html Msg
selectedComponentView scene =
    div []
        (case Scene.selectedComponent scene of
            Nothing ->
                [ text "Select a component" ]

            Just { id } ->
                let
                    components =
                        Scene.selectedComponents scene
                in
                    case Dict.get id components of
                        Nothing ->
                            [ text "Entity does not contain component" ]

                        Just { fixture, params } ->
                            [ paramsView [] params
                            , fixtureView fixture
                            ]
        )


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


availableComponentsListView : Scene -> Html Msg
availableComponentsListView scene =
    let
        keys =
            Dict.keys (Scene.selectedComponents scene)

        available =
            List.filter
                (\component -> List.member component.id keys == False)
                availableComponents

        queuedId =
            Scene.queuedComponentId scene
    in
        div [ availableComponentsStyles ]
            [ div [ availableComponentsListStyles ]
                [ componentsListView (\c -> SceneMsg (QueueComponent c)) queuedId available
                ]
            ]


selectedComponentsListView : Scene -> Html Msg
selectedComponentsListView scene =
    let
        selected =
            Dict.values (Scene.selectedComponents scene)

        selectedId =
            Scene.selectedComponentId scene
    in
        div [ selectedComponentsStyles ]
            [ div [ selectedComponentsListStyles ]
                [ componentsListView (\c -> SceneMsg (SelectComponent c.id)) selectedId selected
                ]
            , hr
            , div [ selectedComponentStyles ]
                [ selectedComponentView scene
                ]
            ]


componentManagerView : Model -> Html Msg
componentManagerView model =
    div [ componentManagerStyles ]
        ([ div [ panelTitleStyles ] [ text "Components" ]
         , hr
         ]
            ++ (case selectedScene model of
                    Nothing ->
                        []

                    Just scene ->
                        (case scene.selectedEntity of
                            Nothing ->
                                [ div [ selectedEntityStyles ] [ text "Select an entity" ]
                                , hr
                                ]

                            Just _ ->
                                [ availableComponentsListView scene
                                , div []
                                    [ hr
                                    , addComponentButton scene.queuedComponent
                                    , removeComponentButton scene.selectedComponent
                                    , hr
                                    ]
                                , selectedComponentsListView scene
                                ]
                        )
               )
        )



-- parseErrorView : Model -> String
-- parseErrorView model =
--     case model.sceneParseError of
--         Nothing ->
--             ""
--         Just err ->
--             err


nodeView : Model -> Int -> TreeNode -> Html Msg
nodeView model depth node =
    div []
        [ case node of
            Directory directory ->
                if List.any Tree.hasJson directory.children then
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
                        [ treeFileItemStyles False depth
                        , onClick (LoadFileOut file.path)
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


sceneParamsInputView : (String -> SceneMsg) -> Bool -> String -> String -> Html Msg
sceneParamsInputView msg narrow label_ val =
    label []
        [ span [ css [ labelStyles ] ] [ text label_ ]
        , input
            [ if narrow then
                css [ inputNarrowStyles ]
              else
                css []
            , value val
            , onBlur (SceneMsg << msg)
            , onEnter (SceneMsg << msg)
            ]
            []
        ]


sceneParamsView : Scene -> Html Msg
sceneParamsView scene =
    div [ sceneParamsStyles ]
        [ sceneParamsInputView SetId True "ID" (String.fromInt scene.id)
        , sceneParamsInputView SetName False "Name" scene.name
        , sceneParamsInputView SetWidth True "Width" (String.fromInt scene.width)
        , sceneParamsInputView SetHeight True "Height" (String.fromInt scene.height)
        ]


sceneCanvasView : Scene -> Html Msg
sceneCanvasView scene =
    div [ sceneCanvasStyles ]
        [ div [ sceneFrameStyles scene.width scene.height ]
            (List.map
                (\entity ->
                    div
                        [ sceneEntityStyles entity.dragVertex
                        , fromUnstyled (Draggable.mouseTrigger () (SceneMsg << DragMsg entity))
                        ]
                        [ text (String.fromInt entity.id) ]
                )
                (Dict.values scene.entities)
            )
        ]


sceneView : Model -> Html Msg
sceneView model =
    case selectedScene model of
        Nothing ->
            div [] []

        Just scene ->
            div [ sceneStyles ]
                [ sceneParamsView scene
                , sceneCanvasView scene
                ]


filename : Scene -> String
filename scene =
    case scene.file of
        Nothing ->
            "Untitled"

        Just file ->
            case List.Extra.last (String.split "/" file) of
                Nothing ->
                    ""

                Just name ->
                    name


tabsListView : Model -> Html Msg
tabsListView model =
    ul [ tabsListStyles ]
        (List.indexedMap
            (\index scene ->
                let
                    selected =
                        index == (selectedSceneIndex model)
                in
                    li
                        [ tabStyles selected
                        , onClick (SelectSceneIndex index)
                        ]
                        [ text (filename scene)
                        , span
                            [ onClick (CloseScene index)
                            ]
                            [ Html.Styled.fromUnstyled (Icon.times [ Icon.xs ])
                            ]
                        ]
            )
            model.scenes
        )



-- [ button
--     [ onClick SelectProjectPathOut ]
--     [ text "select project" ]
-- ]


view : Model -> Html Msg
view model =
    div []
        [ globalStyles
        , div []
            [ tabsListView model
            , treeView model
            , entityManagerView model
            , componentManagerView model
            , sceneView model
            ]
        ]
