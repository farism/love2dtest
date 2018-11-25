port module App exposing (..)

import Maybe
import Browser
import Browser.Dom
import Dict exposing (Dict)
import Draggable exposing (Delta)
import Draggable.Events exposing (onDragBy)
import FontAwesome.Solid as Icon
import Html.Styled.Events exposing (onClick, onInput)
import Html.Styled.Attributes exposing (css, disabled, placeholder, selected, title, value)
import Html.Styled exposing (Attribute, Html, div, fromUnstyled, label, li, option, span, text, ul, toUnstyled)
import Json.Decode as JD
import List.Extra
import Numeral
import Data exposing (availableComponents)
import Entity exposing (Entity)
import Component exposing (Component, Param)
import Helpers exposing (..)
import Scene exposing (Scene, SceneMsg(..))
import Styles exposing (..)
import Tree exposing (TreeNode(..))
import Widgets exposing (button, hr, input, select)


port selectProjectPathIn : (String -> msg) -> Sub msg


port selectProjectPathOut : () -> Cmd msg


port loadFileIn : (( String, String ) -> msg) -> Sub msg


port loadFileOut : String -> Cmd msg


port saveFileOut : ( String, JD.Value ) -> Cmd msg


type alias Flags =
    {}


type Msg
    = DragMsg Entity (Draggable.Msg ())
    | LoadFileIn ( String, String )
    | LoadFileOut String
    | OnDragBy Draggable.Delta
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


dragConfig : Draggable.Config () Msg
dragConfig =
    Draggable.basicConfig OnDragBy


subscriptions : Model -> Sub Msg
subscriptions model =
    let
        draggableSubscription =
            []

        -- case selectedEntity model of
        --     Nothing ->
        --         []
        --     Just entity ->
        --         [ Draggable.subscriptions (DragMsg entity) entity.drag
        --         ]
    in
        Sub.batch
            (draggableSubscription
                ++ [ selectProjectPathIn SelectProjectPathIn
                   , loadFileIn LoadFileIn
                   ]
            )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DragMsg entity dragMsg ->
            ( model, Cmd.none )

        LoadFileIn ( file, json ) ->
            case Scene.decode file json of
                Err err ->
                    ( { model | sceneParseError = Just "Invalid file format" }, Cmd.none )

                Ok scene ->
                    let
                        nextId =
                            Scene.lastId (Dict.values scene.entities)

                        newScene =
                            { scene | file = Just file, selectedEntity = Just nextId, nextId = nextId }

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
                    ( model, loadFileOut (file) )

                Just index ->
                    ( { model | selectedSceneIndex = Just index }, Cmd.none )

        OnDragBy ( dx, dy ) ->
            ( model, Cmd.none )

        SaveFileOut ->
            case selectedScene model of
                Nothing ->
                    ( model, Cmd.none )

                Just scene ->
                    ( model, saveFileOut ( "", Scene.encode scene ) )

        SceneMsg sceneMsg ->
            case List.Extra.getAt (selectedSceneIndex model) model.scenes of
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
            ( model, selectProjectPathOut () )

        SelectSceneIndex index ->
            ( { model | selectedSceneIndex = Just index }, Cmd.none )



-- DragMsg entity dragMsg ->
--     let
--         newModel =
--             { model | selectedEntity = Just entity.id }
--     in
--         case selectedEntity newModel of
--             Nothing ->
--                 ( newModel, Cmd.none )
--             Just e ->
--                 let
--                     ( newEntity, cmds ) =
--                         Draggable.update dragConfig dragMsg e
--                     entities =
--                         Dict.insert (String.fromInt entity.id) newEntity newModel.entities
--                 in
--                     ( { newModel | entities = entities }, cmds )
-- OnDragBy ( dx, dy ) ->
--     case selectedEntity model of
--         Nothing ->
--             ( model, Cmd.none )
--         Just entity ->
--             let
--                 dragVertex =
--                     Vertex (entity.dragVertex.x + dx) (entity.dragVertex.y + dy)
--                 newEntity =
--                     { entity | dragVertex = dragVertex }
--                 entities =
--                     Dict.insert (String.fromInt entity.id) newEntity model.entities
--             in
--                 ( { model | entities = entities }, Cmd.none )
-- UpdateParam key param value ->
--     let
--         componentId =
--             selectedComponentId model
--         newParam =
--             { param | value = validateParam param value }
--         newModel =
--             updateComponents
--                 (\components ->
--                     (Dict.map
--                         (\k component ->
--                             if k == componentId then
--                                 { component | params = Dict.insert key newParam component.params }
--                             else
--                                 component
--                         )
--                         components
--                     )
--                 )
--                 model
--     in
--         ( newModel, Cmd.none )


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



-- updateComponents : (Dict String Component -> Dict String Component) -> Model -> Model
-- updateComponents fn model =
--     let
--         entities =
--             (case selectedEntity model of
--                 Nothing ->
--                     model.entities
--                 Just entity ->
--                     let
--                         newEntity =
--                             { entity | components = fn entity.components }
--                         newEntities =
--                             Dict.insert (String.fromInt entity.id) newEntity model.entities
--                     in
--                         newEntities
--             )
--     in
--         { model | entities = entities }
-- sortParamList : List ( String, Param ) -> List ( String, Param )
-- sortParamList list =
--     List.sortWith
--         (\( _, a ) ( _, b ) -> compare a.order b.order)
--         list
-- formatParam : Param -> String
-- formatParam param =
--     case param.value of
--         String value ->
--             value
--         Int value ->
--             Numeral.format "0" (toFloat value)
--         Float value ->
--             Numeral.format "0.00" value
--         _ ->
--             Debug.toString param.value
-- validateParam : Param -> String -> ParamValue
-- validateParam param newValue =
--     case param.value of
--         Int oldValue ->
--             if newValue == "" then
--                 Int 0
--             else
--                 case String.toInt newValue of
--                     Nothing ->
--                         Int oldValue
--                     Just value ->
--                         Int value
--         Float oldValue ->
--             if newValue == "" then
--                 Float 0
--             else
--                 case String.toFloat newValue of
--                     Nothing ->
--                         Float oldValue
--                     Just value ->
--                         Float value
--         _ ->
--             String newValue
-- input : String -> String -> (String -> Msg) -> Html Msg
-- input key val fn =
--     label [ paramStyle ]
--         [ div [ paramLabelStyle ] [ text (key ++ ": ") ]
--         , input [ paramInputStyle, onEnter fn, onBlur fn, value val ] []
--         ]
-- selectView : String -> String -> List String -> (String -> Msg) -> Html Msg
-- selectView key val options fn =
--     label [ paramStyle ]
--         [ div [ paramLabelStyle ] [ text (key ++ ": ") ]
--         , select
--             [ paramInputStyle
--             , onInput fn
--             , value val
--             ]
--             (List.map
--                 (\opt -> option [ selected (opt == val) ] [ text opt ])
--                 options
--             )
--         ]
-- paramFieldView : String -> Param -> Html Msg
-- paramFieldView key param =
--     case param.options of
--         Nothing ->
--             case param.value of
--                 String str ->
--                     input key str (UpdateParam key param)
--                 Int int ->
--                     input key (Debug.toString int) (UpdateParam key param)
--                 Float float ->
--                     input key (Debug.toString float) (UpdateParam key param)
--                 _ ->
--                     text ""
--         Just opts ->
--             case param.value of
--                 String value ->
--                     selectView key value opts (UpdateParam key param)
--                 _ ->
--                     text ""
-- paramsView : Dict String Param -> Html Msg
-- paramsView params =
--     ul []
--         (params
--             |> Dict.toList
--             |> sortParamList
--             |> List.map
--                 (\( key, param ) ->
--                     li []
--                         [ label []
--                             [ paramFieldView key param
--                             ]
--                         ]
--                 )
--         )
-- bodyView : Body -> Html Msg
-- bodyView body =
--     div []
--         [ div [] [ text "body" ]
--         , ul []
--             [ selectView
--                 "type"
--                 (fromBodyType body.bodyType)
--                 bodyTypes
--                 (\value -> UpdateBody { body | bodyType = toBodyType value })
--             , input
--                 "x"
--                 (Debug.toString body.x)
--                 (\value -> UpdateBody { body | x = (strToFloat value) })
--             , input
--                 "y"
--                 (Debug.toString body.y)
--                 (\value -> UpdateBody { body | y = (strToFloat value) })
--             ]
--         ]
-- shapeView : Shape -> Html Msg
-- shapeView shape =
--     div []
--         (case shape of
--             Rectangle rectangle ->
--                 []
--             Circle circle ->
--                 []
--             _ ->
--                 []
--         )
-- fixtureView : Maybe Fixture -> Html Msg
-- fixtureView fixture =
--     ul []
--         (case fixture of
--             Nothing ->
--                 []
--             Just { body, shape } ->
--                 [ li []
--                     [ bodyView body
--                     ]
--                 , li []
--                     [ shapeView shape
--                     ]
--                 ]
--         )


entityListView : Scene -> Html Msg
entityListView scene =
    let
        selectedId =
            Scene.selectedEntityId scene
    in
        ul []
            (List.map
                (\{ id } ->
                    li
                        [ entityListItemStyles (selectedId == id)
                        , onClick (SceneMsg (SelectEntity id))
                        ]
                        [ text <| String.fromInt id ]
                )
                (scene.entities |> Dict.values |> sortEntities)
            )


selectedEntityView : Scene -> Html Msg
selectedEntityView scene =
    case Scene.selectedEntity scene of
        Nothing ->
            text "Select an entity"

        Just e ->
            input [ entityInputStyles, value e.label, placeholder "Label" ] []


addEntityButton : Html Msg
addEntityButton =
    button [ onClick (SceneMsg AddEntity), title "Add Entity" ]
        [ fromUnstyled (Icon.plus []) ]


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
            [ fromUnstyled (Icon.minus []) ]


entityManagerView : Model -> Html Msg
entityManagerView model =
    div [ entityManagerStyles ]
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
            [ fromUnstyled (Icon.plus []) ]


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
            [ fromUnstyled (Icon.minus []) ]


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
                            [--   fixtureView fixture
                             -- , paramsView params
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
        (case selectedScene model of
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



-- parseErrorView : Model -> String
-- parseErrorView model =
--     case model.sceneParseError of
--         Nothing ->
--             ""
--         Just err ->
--             err
-- toolbarView : Model -> Html Msg
-- toolbarView model =
--     div
--         [ toolbarStyles ]
--         [ input [ onInput SetSceneId, value (String.fromInt model.sceneId) ] []
--         , input [ onInput SetSceneName, value model.sceneName ] []
--         , button [ onClick SaveFileOut ] [ text "save scene" ]
--         , button [ onClick Undo ] [ text "undo" ]
--         , button [ onClick Redo ] [ text "redo" ]
--         , div [] [ text ("File: " ++ (parseErrorView model)) ]
--         ]


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
sceneParamsInputView msg narrow label_ value_ =
    label []
        [ span [ css [ labelStyles ] ] [ text label_ ]
        , input
            [ if narrow then
                css [ inputNarrowStyles ]
              else
                css []
            , value value_
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


sceneView : Model -> Html Msg
sceneView model =
    case selectedScene model of
        Nothing ->
            div [] []

        Just scene ->
            div [ sceneStyles ]
                [ sceneParamsView scene
                ]



-- div [ sceneStyles ]
--     [ div []
--         (List.map
--             (\entity ->
--                 div
--                     [ draggableStyles entity.dragVertex
--                     , fromUnstyled (Draggable.mouseTrigger () (DragMsg entity))
--                     ]
--                     []
--             )
--             (Dict.values model.entities)
--         )
--     ]


filename : Scene -> String
filename scene =
    case scene.file of
        Nothing ->
            "Untitled"

        Just f ->
            case f |> String.split "/" |> List.Extra.last of
                Nothing ->
                    ""

                Just name ->
                    name


tabsListView : Model -> Html Msg
tabsListView model =
    ul [ tabsListStyles ]
        (List.indexedMap
            (\index scene ->
                li
                    [ tabStyles (index == (selectedSceneIndex model))
                    , onClick (SelectSceneIndex index)
                    ]
                    [ text (filename scene) ]
            )
            model.scenes
        )


view : Model -> Html Msg
view model =
    div []
        [ globalStyles
        , div []
            (case model.tree of
                Nothing ->
                    [ button
                        [ onClick SelectProjectPathOut ]
                        [ text "select project" ]
                    ]

                Just tree ->
                    [ --   toolbarView model
                      tabsListView model
                    , treeView model
                    , entityManagerView model
                    , componentManagerView model
                    , sceneView model
                    ]
            )
        ]
