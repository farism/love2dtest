module Serializers exposing (decodeTree, decodeLevel, encodeLevel)

import Dict exposing (Dict)
import Json.Encode as JE
import Json.Decode as JD
import Json.Decode.Pipeline exposing (hardcoded, optional, required, resolve)
import Draggable
import Helpers exposing (..)
import Types exposing (..)


decodeTree : String -> Result JD.Error TreeNode
decodeTree string =
    case JD.decodeString (treeDecoder "directory") string of
        Err err ->
            Err (Debug.log "decode tree error" err)

        Ok tree ->
            Ok tree


decodeLevel : String -> Result JD.Error Level
decodeLevel string =
    case JD.decodeString levelDecoder string of
        Err err ->
            Err (Debug.log "decode level error" err)

        Ok level ->
            Ok level


encodeLevel : Int -> String -> Dict String Entity -> JE.Value
encodeLevel id name entities =
    levelEncoder id name entities



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


levelDecoder : JD.Decoder Level
levelDecoder =
    JD.succeed Level
        |> required "id" JD.int
        |> required "name" JD.string
        |> required "entities" (JD.dict entityDecoder)


entityDecoder : JD.Decoder Entity
entityDecoder =
    JD.succeed Entity
        |> required "id" JD.int
        |> required "label" JD.string
        |> required "components" (JD.dict componentDecoder)
        |> required "dragpoint" vertexDecoder
        |> hardcoded Draggable.init


componentDecoder : JD.Decoder Component
componentDecoder =
    JD.succeed Component
        |> required "id" JD.string
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
        [ JD.string |> JD.andThen (JD.succeed << StringValue)
        , JD.int |> JD.andThen (JD.succeed << IntValue)
        , JD.float |> JD.andThen (JD.succeed << FloatValue)
        , JD.bool |> JD.andThen (JD.succeed << BoolValue)
        ]



-- bodyDecoder : JD.Decoder Body
-- bodyDecoder =
--     JD.succeed Body
--         |> required "bodyType" bodyTypeDecoder
--         |> required "vertex" vertexDecoder
--         |> required "category" (JD.list JD.int)
--         |> required "mask" (JD.list JD.int)
-- bodyTypeDecoder : JD.Decoder BodyType
-- bodyTypeDecoder =
--     (JD.string
--         |> JD.andThen
--             (\x ->
--                 JD.succeed
--                     (case x of
--                         _ ->
--                             Static
--                     )
--             )
--     )
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


levelEncoder : Int -> String -> Dict String Entity -> JE.Value
levelEncoder id name entities =
    JE.object
        [ ( "id", JE.int id )
        , ( "name", JE.string name )
        , ( "entities", dictEncoder entityEncoder entities )
        ]


entityEncoder : Entity -> JE.Value
entityEncoder { id, label, components, dragpoint } =
    JE.object
        [ ( "id", JE.int id )
        , ( "label", JE.string label )
        , ( "components", dictEncoder componentEncoder components )
        , ( "dragpoint", vertexEncoder dragpoint )
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
                StringValue newValue ->
                    JE.string newValue

                IntValue newValue ->
                    JE.int newValue

                FloatValue newValue ->
                    JE.float newValue

                _ ->
                    JE.string ""
            )
          )
        ]
