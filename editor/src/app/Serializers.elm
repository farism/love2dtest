module Serializers exposing (decodeTree, decodeLevel, encodeLevel, mouseOffsetDecoder)

import Dict exposing (Dict)
import Json.Encode as JE
import Json.Decode as JD
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


mouseOffsetDecoder : JD.Decoder Point
mouseOffsetDecoder =
    JD.map2 Point
        (JD.field "offsetX" JD.float)
        (JD.field "offsetY" JD.float)


pointDecoder : JD.Decoder Point
pointDecoder =
    JD.map2 Point
        (JD.field "x" JD.float)
        (JD.field "y" JD.float)


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
    JD.map Directory <|
        JD.map3 DirectoryFields
            (JD.field "path" JD.string)
            (JD.field "name" JD.string)
            (JD.field "children"
                (JD.list
                    ((JD.field "type" JD.string) |> JD.andThen treeDecoder)
                )
            )


fileDecoder : JD.Decoder TreeNode
fileDecoder =
    JD.map File <|
        JD.map3 FileFields
            (JD.field "path" JD.string)
            (JD.field "name" JD.string)
            (JD.field "extension" JD.string)


levelDecoder : JD.Decoder Level
levelDecoder =
    JD.map3 Level
        (JD.field "id" JD.int)
        (JD.field "name" JD.string)
        (JD.field "entities" (JD.dict entityDecoder))


entityDecoder : JD.Decoder Entity
entityDecoder =
    JD.map4 Entity
        (JD.field "id" JD.int)
        (JD.field "label" JD.string)
        (JD.field "position" pointDecoder)
        (JD.field "components" (JD.dict componentDecoder))


componentDecoder : JD.Decoder Component
componentDecoder =
    JD.field "id" JD.string
        |> JD.andThen
            (\_ ->
                JD.succeed
                    { id = "position"
                    , params = Dict.empty
                    }
            )



-- ENCODERS


dictEncoder : (a -> JE.Value) -> Dict String a -> JE.Value
dictEncoder encoder dict =
    Dict.toList dict
        |> List.map (\( k, v ) -> ( k, encoder v ))
        |> JE.object


pointEncoder : Point -> JE.Value
pointEncoder point =
    JE.object
        [ ( "x", JE.float point.x )
        , ( "x", JE.float point.y )
        ]


levelEncoder : Int -> String -> Dict String Entity -> JE.Value
levelEncoder id name entities =
    JE.object
        [ ( "id", JE.int id )
        , ( "name", JE.string name )
        , ( "entities", dictEncoder entityEncoder entities )
        ]


entityEncoder : Entity -> JE.Value
entityEncoder entity =
    JE.object
        [ ( "id", JE.int entity.id )
        , ( "label", JE.string entity.label )
        , ( "position", pointEncoder entity.position )
          -- , ( "components", dictEncoder componentEncoder entity.components )
        ]



-- componentEncoder : String -> JE.Value
-- componentEncoder component =
--     case component of
