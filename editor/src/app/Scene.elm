module Scene
    exposing
        ( Scene
        , SceneMsg(..)
        , decode
        , encode
        , init
        , lastId
        , queuedComponentId
        , selectedComponentId
        , selectedComponent
        , selectedComponents
        , selectedEntityId
        , selectedEntity
        , subscriptions
        , update
        )

import Dict exposing (Dict)
import Draggable exposing (Delta)
import Json.Decode.Pipeline as JDP
import Json.Decode.Extra as JDE
import Json.Decode as JD
import Json.Encode as JE
import Entity exposing (Entity)
import Component exposing (Component, Param, ParamValue(..))
import Helpers exposing (dictEncoder, strToFloat, strToInt)
import Vertex exposing (Vertex)


type alias Scene =
    { entities : Dict Int Entity
    , file : Maybe String
    , height : Int
    , id : Int
    , name : String
    , nextId : Int
    , queuedComponent : Maybe Component
    , selectedComponent : Maybe String
    , selectedEntity : Maybe Int
    , width : Int
    }


type SceneMsg
    = AddComponent Component
    | AddEntity
    | DragMsg Entity (Draggable.Msg ())
    | OnDragBy Draggable.Delta
    | QueueComponent Component
    | RemoveComponent String
    | RemoveEntity Int
    | SelectComponent String
    | SelectEntity Int
    | SetLabel Entity String
    | SetHeight String
    | SetId String
    | SetName String
    | SetWidth String
    | UpdateParam String Param String


subscriptions : (SceneMsg -> msg) -> Scene -> List (Sub msg)
subscriptions msg scene =
    case selectedEntity scene of
        Nothing ->
            []

        Just entity ->
            [ Draggable.subscriptions (msg << DragMsg entity) entity.drag
            ]


init : Scene
init =
    { entities = Dict.empty
    , file = Nothing
    , height = 0
    , id = 0
    , name = "New Scene"
    , nextId = 0
    , queuedComponent = Nothing
    , selectedComponent = Nothing
    , selectedEntity = Nothing
    , width = 0
    }


update : SceneMsg -> Scene -> ( Scene, Cmd SceneMsg )
update msg scene =
    case msg of
        AddComponent component ->
            let
                newScene =
                    updateComponents
                        (\components -> Dict.insert component.id component components)
                        scene
            in
                ( { newScene
                    | selectedComponent = Just component.id
                    , queuedComponent = Nothing
                  }
                , Cmd.none
                )

        AddEntity ->
            let
                entity =
                    Entity scene.nextId "" Dict.empty { x = 0, y = 0 } Draggable.init

                entities =
                    Dict.insert entity.id entity scene.entities
            in
                ( { scene
                    | nextId = scene.nextId + 1
                    , entities = entities
                    , selectedEntity = Just entity.id
                  }
                , Cmd.none
                )

        DragMsg entity dragMsg ->
            let
                newScene =
                    { scene | selectedEntity = Just entity.id }
            in
                case selectedEntity scene of
                    Nothing ->
                        ( newScene, Cmd.none )

                    Just e ->
                        let
                            ( newEntity, cmds ) =
                                Draggable.update dragConfig dragMsg e

                            entities =
                                Dict.insert entity.id newEntity scene.entities
                        in
                            ( { newScene | entities = entities }, cmds )

        OnDragBy ( dx, dy ) ->
            case selectedEntity scene of
                Nothing ->
                    ( scene, Cmd.none )

                Just entity ->
                    let
                        dragVertex =
                            Vertex (entity.dragVertex.x + dx) (entity.dragVertex.y + dy)

                        newEntity =
                            { entity | dragVertex = dragVertex }

                        entities =
                            Dict.insert entity.id newEntity scene.entities
                    in
                        ( { scene | entities = entities }, Cmd.none )

        RemoveComponent id ->
            let
                newScene =
                    updateComponents
                        (\components -> Dict.remove id components)
                        scene
            in
                ( { newScene
                    | selectedComponent = Nothing
                  }
                , Cmd.none
                )

        RemoveEntity id ->
            let
                entities =
                    Dict.remove id scene.entities
            in
                ( { scene | entities = entities, selectedEntity = Nothing }, Cmd.none )

        QueueComponent component ->
            ( { scene | queuedComponent = Just component, selectedComponent = Nothing }, Cmd.none )

        SelectEntity id ->
            ( { scene | selectedEntity = Just id }, Cmd.none )

        SelectComponent id ->
            ( { scene | queuedComponent = Nothing, selectedComponent = Just id }, Cmd.none )

        SetLabel entity label ->
            let
                newEntity =
                    { entity | label = label }

                entities =
                    Dict.insert newEntity.id newEntity scene.entities
            in
                ( { scene | entities = entities }, Cmd.none )

        SetHeight height ->
            ( { scene | height = strToInt scene.height height }, Cmd.none )

        SetId id ->
            ( { scene | id = strToInt scene.id id }, Cmd.none )

        SetName name ->
            ( { scene | name = name }, Cmd.none )

        SetWidth width ->
            ( { scene | width = strToInt scene.width width }, Cmd.none )

        UpdateParam key param value ->
            let
                newScene =
                    updateComponent
                        (\component ->
                            let
                                newParam =
                                    updateParam value param
                            in
                                { component | params = Dict.insert key newParam component.params }
                        )
                        scene
            in
                ( newScene, Cmd.none )


dragConfig : Draggable.Config () SceneMsg
dragConfig =
    Draggable.basicConfig OnDragBy


lastId : List Entity -> Int
lastId entities =
    case List.maximum <| List.map .id entities of
        Nothing ->
            0

        Just id ->
            id


selectedEntityId : Scene -> Int
selectedEntityId scene =
    case scene.selectedEntity of
        Nothing ->
            0

        Just id ->
            id


selectedEntity : Scene -> Maybe Entity
selectedEntity scene =
    Dict.get (selectedEntityId scene) scene.entities


queuedComponentId : Scene -> String
queuedComponentId scene =
    case scene.queuedComponent of
        Nothing ->
            ""

        Just c ->
            c.id


selectedComponentId : Scene -> String
selectedComponentId scene =
    case scene.selectedComponent of
        Nothing ->
            ""

        Just id ->
            id


selectedComponent : Scene -> Maybe Component
selectedComponent scene =
    case selectedEntity scene of
        Nothing ->
            Nothing

        Just entity ->
            Dict.get (selectedComponentId scene) entity.components


selectedComponents : Scene -> Dict String Component
selectedComponents scene =
    case selectedEntity scene of
        Nothing ->
            Dict.empty

        Just entity ->
            case Dict.get entity.id scene.entities of
                Nothing ->
                    Dict.empty

                Just e ->
                    e.components


updateParam : String -> Param -> Param
updateParam value param =
    case param.value of
        Int oldValue ->
            { param | value = Int (strToInt oldValue value) }

        Float oldValue ->
            { param | value = Float (strToFloat oldValue value) }

        _ ->
            { param | value = String value }


updateComponents : (Dict String Component -> Dict String Component) -> Scene -> Scene
updateComponents updater scene =
    case selectedEntity scene of
        Nothing ->
            scene

        Just entity ->
            let
                newEntity =
                    { entity | components = updater entity.components }

                entities =
                    Dict.insert newEntity.id newEntity scene.entities
            in
                { scene | entities = entities }


updateComponent : (Component -> Component) -> Scene -> Scene
updateComponent updater scene =
    case selectedComponent scene of
        Nothing ->
            scene

        Just component ->
            updateComponents
                (\components ->
                    Dict.map
                        (\_ c ->
                            if c.id == component.id then
                                updater c
                            else
                                c
                        )
                        components
                )
                scene


decode : String -> String -> Result JD.Error Scene
decode file string =
    case JD.decodeString (sceneDecoder file) string of
        Err err ->
            Err (Debug.log "decode level error" err)

        Ok level ->
            Ok level


sceneDecoder : String -> JD.Decoder Scene
sceneDecoder file =
    JD.succeed Scene
        |> JDP.required "entities" (JDE.dict2 JD.int Entity.decoder)
        |> JDP.hardcoded (Just file)
        |> JDP.required "height" JD.int
        |> JDP.required "id" JD.int
        |> JDP.required "name" JD.string
        |> JDP.hardcoded 0
        |> JDP.hardcoded Nothing
        |> JDP.hardcoded Nothing
        |> JDP.hardcoded Nothing
        |> JDP.required "width" JD.int


encode : Scene -> JE.Value
encode { id, name, entities } =
    JE.object
        [ ( "id", JE.int id )
        , ( "name", JE.string name )
        , ( "entities", dictEncoder Entity.encoder entities )
        ]
