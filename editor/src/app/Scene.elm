module Scene
    exposing
        ( Scene
        , SceneMsg(..)
        , decode
        , encode
        , init
        , lastEntityId
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
import Component exposing (Component)
import Fixture exposing (Fixture, FixtureMsg(..))
import Helpers exposing (dictEncoder, strToFloat, strToInt)
import Param exposing (Param, ParamValue(..))
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
    | FixtureMsg FixtureMsg
    | OnDragBy Draggable.Delta
    | QueueComponent Component
    | RemoveComponent String
    | RemoveEntity Int
    | SelectComponent String
    | SelectEntity Int
    | SetEntityLabel Entity String
    | SetHeight String
    | SetId String
    | SetName String
    | SetWidth String
    | UpdateParam (List ( String, Param )) String


subscriptions : (SceneMsg -> msg) -> Scene -> List (Sub msg)
subscriptions msg scene =
    Maybe.withDefault []
        (selectedEntity scene
            |> Maybe.andThen
                (\e -> Just [ Draggable.subscriptions (msg << DragMsg e) e.drag ])
        )


init : Scene
init =
    { entities = Dict.empty
    , file = Nothing
    , height = 480
    , id = 0
    , name = "New Scene"
    , nextId = 0
    , queuedComponent = Nothing
    , selectedComponent = Nothing
    , selectedEntity = Nothing
    , width = 640
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
                ( { newScene | selectedComponent = Just component.id, queuedComponent = Nothing }, Cmd.none )

        AddEntity ->
            let
                entity =
                    Entity scene.nextId "" Dict.empty { x = 0, y = 0 } Draggable.init
            in
                ( { scene
                    | nextId = scene.nextId + 1
                    , entities = Dict.insert entity.id entity scene.entities
                    , selectedEntity = Just entity.id
                  }
                , Cmd.none
                )

        DragMsg entity dragMsg ->
            let
                newScene =
                    { scene | selectedEntity = Just entity.id }
            in
                case selectedEntity newScene of
                    Nothing ->
                        ( newScene, Cmd.none )

                    Just e ->
                        let
                            ( newEntity, cmds ) =
                                Draggable.update dragConfig dragMsg e
                        in
                            ( { newScene | entities = Dict.insert entity.id newEntity scene.entities }, cmds )

        FixtureMsg fixtureMsg ->
            let
                fixture =
                    selectedComponent scene
                        |> Maybe.andThen .fixture
                        |> Maybe.andThen (Just << (Fixture.update fixtureMsg))

                newScene =
                    updateComponent
                        (\component -> { component | fixture = fixture })
                        scene
            in
                ( newScene, Cmd.none )

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
                ( { newScene | selectedComponent = Nothing }, Cmd.none )

        RemoveEntity id ->
            ( { scene | entities = Dict.remove id scene.entities, selectedEntity = Nothing }, Cmd.none )

        QueueComponent component ->
            ( { scene | queuedComponent = Just component, selectedComponent = Nothing }, Cmd.none )

        SelectEntity id ->
            ( { scene | selectedEntity = Just id }, Cmd.none )

        SelectComponent id ->
            ( { scene | queuedComponent = Nothing, selectedComponent = Just id }, Cmd.none )

        SetEntityLabel entity label ->
            ( { scene | entities = Dict.insert entity.id { entity | label = label } scene.entities }, Cmd.none )

        SetHeight height ->
            ( { scene | height = strToInt scene.height height }, Cmd.none )

        SetId id ->
            ( { scene | id = strToInt scene.id id }, Cmd.none )

        SetName name ->
            ( { scene | name = name }, Cmd.none )

        SetWidth width ->
            ( { scene | width = strToInt scene.width width }, Cmd.none )

        UpdateParam path value ->
            let
                newScene =
                    updateComponent
                        (\component -> { component | params = updateParam path value component.params })
                        scene
            in
                ( newScene, Cmd.none )


dragConfig : Draggable.Config () SceneMsg
dragConfig =
    Draggable.basicConfig OnDragBy


lastEntityId : List Entity -> Int
lastEntityId entities =
    Maybe.withDefault 0 (List.maximum <| List.map .id entities)


selectedEntityId : Scene -> Int
selectedEntityId scene =
    Maybe.withDefault 0 scene.selectedEntity


selectedEntity : Scene -> Maybe Entity
selectedEntity scene =
    Dict.get (selectedEntityId scene) scene.entities


queuedComponentId : Scene -> String
queuedComponentId scene =
    Maybe.withDefault "" (Maybe.map .id scene.queuedComponent)


selectedComponentId : Scene -> String
selectedComponentId scene =
    Maybe.withDefault "" scene.selectedComponent


selectedComponent : Scene -> Maybe Component
selectedComponent scene =
    selectedEntity scene
        |> Maybe.andThen
            (\e ->
                Dict.get (selectedComponentId scene) e.components
            )


selectedComponents : Scene -> Dict String Component
selectedComponents scene =
    Maybe.withDefault
        Dict.empty
        (selectedEntity scene
            |> (Maybe.andThen (Just << .components))
        )


updateComponents : (Dict String Component -> Dict String Component) -> Scene -> Scene
updateComponents updater scene =
    Maybe.withDefault
        scene
        (selectedEntity scene
            |> Maybe.andThen
                ((\entity ->
                    let
                        newEntity =
                            { entity | components = updater entity.components }
                    in
                        Just { scene | entities = Dict.insert entity.id newEntity scene.entities }
                 )
                )
        )


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


updateParam : List ( String, Param ) -> String -> Dict String Param -> Dict String Param
updateParam path value params =
    case path of
        [] ->
            params

        ( key, param ) :: [] ->
            Dict.insert key { param | value = updateParamValue value param.value } params

        ( key, param ) :: newPath ->
            case param.value of
                Dict oldValue ->
                    Dict.insert key { param | value = Dict (updateParam newPath value oldValue) } params

                _ ->
                    params


updateParamValue : String -> ParamValue -> ParamValue
updateParamValue value paramValue =
    case paramValue of
        Category oldValue ->
            Category []

        Float oldValue ->
            Float (strToFloat oldValue value)

        Int oldValue ->
            Int (strToInt oldValue value)

        Mask oldValue ->
            Mask []

        Select options oldValue ->
            Select options value

        _ ->
            String value


decode : String -> String -> Result JD.Error Scene
decode file string =
    case JD.decodeString (decoder file) string of
        Err err ->
            Err (Debug.log "decode scene error" err)

        Ok level ->
            Ok level


decoder : String -> JD.Decoder Scene
decoder file =
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
