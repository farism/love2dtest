module Serializers exposing (decodeTree, decodeScene, encodeScene)

import Dict exposing (Dict)
import Json.Encode as JE
import Json.Decode as JD
import Json.Decode.Pipeline exposing (hardcoded, optional, required, resolve)
import Draggable
import Helpers exposing (..)
import Component exposing (..)
import Entity exposing (..)
import Scene exposing (..)
import Tree exposing (..)
import Vertex exposing (..)


decodeTree : String -> Result JD.Error TreeNode
decodeTree string =
    case JD.decodeString (treeDecoder "directory") string of
        Err err ->
            Err (Debug.log "decode tree error" err)

        Ok tree ->
            Ok tree


decodeScene : String -> String -> Result JD.Error Scene
decodeScene file string =
    case JD.decodeString (levelDecoder file) string of
        Err err ->
            Err (Debug.log "decode level error" err)

        Ok level ->
            Ok level


encodeScene : Scene -> JE.Value
encodeScene scene =
    levelEncoder scene



-- DECODERS


vertexDecoder : JD.Decoder Vertex
vertexDecoder =
    JD.succeed Vertex
        |> required "x" JD.float
        |> required "y" JD.float


treeDecoder : String -> JD.Decoder TreeNode
treeDecoder type_ =
    case type_ of
        "directory" ->
            directoryDecoder

        "file" ->
            fileDecoder

        _ ->
            directoryDecoder


directoryDecoder : JD.Decoder TreeNode
directoryDecoder =
    JD.map Directory
        (JD.succeed DirectoryFields
            |> required "path" JD.string
            |> required "name" JD.string
            |> required "children"
                (JD.list (JD.field "type" JD.string |> JD.andThen treeDecoder))
        )


fileDecoder : JD.Decoder TreeNode
fileDecoder =
    JD.map File
        (JD.succeed FileFields
            |> required "path" JD.string
            |> required "name" JD.string
            |> required "extension" JD.string
        )


levelDecoder : String -> JD.Decoder Scene
levelDecoder file =
    JD.succeed Scene
        |> hardcoded file
        |> required "id" JD.int
        |> required "name" JD.string
        |> required "width" JD.int
        |> required "height" JD.int
        |> required "entities" (JD.dict entityDecoder)
        |> hardcoded 0


entityDecoder : JD.Decoder Entity
entityDecoder =
    JD.succeed Entity
        |> required "id" JD.int
        |> required "label" JD.string
        |> required "components" (JD.dict componentDecoder)
        |> required "dragVertex" vertexDecoder
        |> hardcoded Draggable.init


componentDecoder : JD.Decoder Component
componentDecoder =
    JD.succeed Component
        |> required "id" JD.string
        |> optional "fixture" fixtureDecoder Nothing
        |> required "params" (JD.dict paramDecoder)


paramDecoder : JD.Decoder Param
paramDecoder =
    JD.succeed Param
        |> required "order" JD.int
        |> optional "options" (JD.maybe (JD.list JD.string)) Nothing
        |> required "value" paramValueDecoder


paramValueDecoder : JD.Decoder ParamValue
paramValueDecoder =
    JD.oneOf
        [ JD.string |> JD.andThen (JD.succeed << String)
        , JD.int |> JD.andThen (JD.succeed << Int)
        , JD.float |> JD.andThen (JD.succeed << Float)
        , JD.bool |> JD.andThen (JD.succeed << Bool)
        ]


fixtureDecoder : JD.Decoder (Maybe Fixture)
fixtureDecoder =
    (JD.map Just)
        (JD.succeed Fixture
            |> required "body" bodyDecoder
            |> required "shape" shapeDecoder
            |> required "density" JD.float
            |> required "friction" JD.float
        )


bodyDecoder : JD.Decoder Body
bodyDecoder =
    JD.succeed Body
        |> required "bodyType" bodyTypeDecoder
        |> required "category" (JD.list JD.int)
        |> required "mask" (JD.list JD.int)
        |> required "x" JD.float
        |> required "y" JD.float


bodyTypeDecoder : JD.Decoder BodyType
bodyTypeDecoder =
    (JD.string |> JD.andThen (\bodyType -> JD.succeed (toBodyType bodyType)))


shapeDecoder : JD.Decoder Shape
shapeDecoder =
    JD.succeed defaultShape



-- shapeTypeDecoder : JD.Decoder ShapeType
-- shapeTypeDecoder =
--     (JD.string |> JD.andThen (\bodyType -> JD.succeed toBodyType bodyType))
-- ENCODERS


dictEncoder : (a -> JE.Value) -> Dict String a -> JE.Value
dictEncoder encoder dict =
    Dict.toList dict
        |> List.map (\( k, v ) -> ( k, encoder v ))
        |> JE.object


vertexEncoder : Vertex -> JE.Value
vertexEncoder { x, y } =
    JE.object
        [ ( "x", JE.float x )
        , ( "y", JE.float y )
        ]


levelEncoder : Scene -> JE.Value
levelEncoder { id, name, entities } =
    JE.object
        [ ( "id", JE.int id )
        , ( "name", JE.string name )
        , ( "entities", dictEncoder entityEncoder entities )
        ]


entityEncoder : Entity -> JE.Value
entityEncoder { id, label, components, dragVertex } =
    JE.object
        [ ( "id", JE.int id )
        , ( "label", JE.string label )
        , ( "components", dictEncoder componentEncoder components )
        , ( "dragVertex", vertexEncoder dragVertex )
        ]


componentEncoder : Component -> JE.Value
componentEncoder { id, params } =
    JE.object
        [ ( "id", JE.string id )
        , ( "params", dictEncoder paramEncoder params )
        ]


paramEncoder : Param -> JE.Value
paramEncoder { order, value } =
    JE.object
        [ ( "order", JE.int order )
        , ( "value"
          , (case value of
                String newValue ->
                    JE.string newValue

                Int newValue ->
                    JE.int newValue

                Float newValue ->
                    JE.float newValue

                _ ->
                    JE.string ""
            )
          )
        ]
