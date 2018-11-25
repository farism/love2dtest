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
    | QueueComponent Component
    | RemoveComponent String
    | RemoveEntity Int
    | SelectComponent String
    | SelectEntity Int
    | SetHeight String
    | SetId String
    | SetName String
    | SetWidth String
    | UpdateParam String Param String


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
            case selectedEntity scene of
                Nothing ->
                    ( scene, Cmd.none )

                Just e ->
                    let
                        entity =
                            { e | components = Dict.insert component.id component e.components }

                        entities =
                            Dict.insert entity.id entity scene.entities
                    in
                        ( { scene
                            | entities = entities
                            , selectedComponent = Just component.id
                            , queuedComponent = Nothing
                          }
                        , Cmd.none
                        )

        AddEntity ->
            let
                nextId =
                    scene.nextId + 1

                entity =
                    Entity nextId "" Dict.empty { x = 0, y = 0 } Draggable.init

                entities =
                    Dict.insert entity.id entity scene.entities
            in
                ( { scene
                    | nextId = nextId
                    , entities = entities
                    , selectedEntity = Just entity.id
                  }
                , Cmd.none
                )

        RemoveComponent id ->
            case selectedEntity scene of
                Nothing ->
                    ( scene, Cmd.none )

                Just e ->
                    let
                        entity =
                            { e | components = Dict.remove id e.components }

                        entities =
                            Dict.insert entity.id entity scene.entities
                    in
                        ( { scene
                            | entities = entities
                            , selectedComponent = Nothing
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

        SetHeight height ->
            ( { scene | height = strToInt scene.height height }, Cmd.none )

        SetId id ->
            ( { scene | id = strToInt scene.id id }, Cmd.none )

        SetName name ->
            ( { scene | name = name }, Cmd.none )

        SetWidth width ->
            ( { scene | width = strToInt scene.width width }, Cmd.none )

        UpdateParam key param value ->
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
