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
        , selectedComponents
        , selectedEntityId
        , selectedEntity
        , update
        )

import Dict exposing (Dict)
import Draggable exposing (Delta)
import Json.Decode.Pipeline as JDP
import Json.Decode.Extra as JDE
import Json.Decode as JD
import Json.Encode as JE
import Entity exposing (Entity)
import Component exposing (Component)
import Helpers exposing (dictEncoder, strToFloat, strToInt)


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
    = AddEntity
    | RemoveEntity Int
    | QueueComponent Component
    | SelectComponent String
    | SelectEntity Int
    | SetHeight String
    | SetId String
    | SetName String
    | SetWidth String


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
        AddEntity ->
            let
                nextId =
                    scene.nextId + 1

                entity =
                    Entity nextId "" Dict.empty { x = 0, y = 0 } Draggable.init

                entities =
                    Dict.insert entity.id entity scene.entities
            in
                ( { scene | nextId = nextId, entities = entities, selectedEntity = Just entity.id }, Cmd.none )

        RemoveEntity id ->
            let
                entities =
                    Dict.remove id scene.entities
            in
                ( { scene | entities = entities, selectedEntity = Nothing }, Cmd.none )

        SelectEntity id ->
            ( { scene | selectedEntity = Just id }, Cmd.none )

        SetHeight height ->
            ( { scene | height = strToInt scene.height height }, Cmd.none )

        SetId id ->
            ( { scene | id = strToInt scene.id id }, Cmd.none )

        SetName name ->
            ( { scene | name = name }, Cmd.none )

        SetWidth width ->
            ( { scene | height = strToInt scene.width width }, Cmd.none )

        _ ->
            ( scene, Cmd.none )


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
