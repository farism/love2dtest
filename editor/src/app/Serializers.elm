module Serializers exposing (decodeTree, decodeLevel, encodeLevel, mouseOffsetDecoder)

import Dict exposing (Dict)
import Json.Encode as JE
import Json.Decode as JD
import Json.Decode.Pipeline exposing (hardcoded, optional, required, resolve)
import Draggable
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
    JD.succeed Point
        |> required "offsetX" JD.float
        |> required "offsetY" JD.float


pointDecoder : JD.Decoder Point
pointDecoder =
    JD.succeed Point
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
    JD.map Directory <|
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
        |> required "dragpoint" pointDecoder
        |> hardcoded Draggable.init


componentDecoder : JD.Decoder Component
componentDecoder =
    JD.succeed Component
        |> required "id" JD.string
        |> required "params"
            (JD.dict
                (JD.oneOf
                    [ paramDecoder String JD.string
                    , paramDecoder Int JD.int
                    , paramDecoder Float JD.float
                    , paramDecoder Bool JD.bool
                    ]
                )
            )


paramDecoder : ParamType -> JD.Decoder a -> JD.Decoder Param
paramDecoder paramType decoder =
    JD.succeed Param
        |> required "order" JD.int
        |> hardcoded paramType
        |> optional "options" (JD.maybe (JD.list JD.string)) Nothing
        |> required "value"
            (decoder
                |> JD.andThen (\x -> JD.succeed (Debug.toString x))
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
        , ( "y", JE.float point.y )
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
        , ( "components", dictEncoder componentEncoder entity.components )
        , ( "dragpoint", pointEncoder entity.dragpoint )
        ]


componentEncoder : Component -> JE.Value
componentEncoder component =
    JE.object
        [ ( "id", JE.string component.id )
        , ( "params", dictEncoder paramEncoder component.params )
        ]


paramEncoder : Param -> JE.Value
paramEncoder param =
    JE.object
        [ ( "order", JE.int param.order )
        , ( "type", paramTypeEncoder param )
        , ( "value", paramValueEncoder param )
        ]


paramTypeEncoder : Param -> JE.Value
paramTypeEncoder param =
    JE.string
        (case param.paramType of
            String ->
                "string"

            Int ->
                "int"

            Float ->
                "float"

            Bool ->
                "bool"
        )


toInt : String -> Int
toInt value =
    if value == "" then
        0
    else
        case String.toInt value of
            Nothing ->
                0

            Just int ->
                int


toFloat : String -> Float
toFloat value =
    if value == "" then
        0.0
    else
        case String.toFloat value of
            Nothing ->
                0.0

            Just int ->
                int


paramValueEncoder : Param -> JE.Value
paramValueEncoder param =
    (case param.paramType of
        String ->
            JE.string param.value

        Int ->
            JE.int (toInt param.value)

        Float ->
            JE.float (toFloat param.value)

        _ ->
            JE.string ""
    )
