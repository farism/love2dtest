module Param exposing (Param, ParamValue(..), decoder, encoder)

import Dict exposing (Dict)
import Json.Decode.Pipeline as JDE
import Json.Decode as JD
import Json.Encode as JE
import Vertex exposing (Vertex)


type ParamValue
    = Bool Bool
    | Category (List Int)
    | Dict (Dict String Param)
    | Float Float
    | Int Int
    | Mask (List Int)
    | Select (List String) String
    | String String
    | Vertices (List Vertex)


type alias Param =
    { order : Int
    , value : ParamValue
    }


decoder : JD.Decoder Param
decoder =
    JD.succeed Param
        |> JDE.required "order" JD.int
        |> JDE.required "value" paramValueDecoder


encoder : Param -> JE.Value
encoder { order, value } =
    JE.object
        [ ( "order", JE.int order )
        , ( "value", paramValueEncoder value )
        ]


paramValueDecoder : JD.Decoder ParamValue
paramValueDecoder =
    JD.oneOf
        [ JD.string |> JD.andThen (JD.succeed << String)
        , JD.int |> JD.andThen (JD.succeed << Int)
        , JD.float |> JD.andThen (JD.succeed << Float)
        , JD.bool |> JD.andThen (JD.succeed << Bool)
        ]


paramValueEncoder : ParamValue -> JE.Value
paramValueEncoder value =
    (case value of
        String newValue ->
            JE.string newValue

        Int newValue ->
            JE.int newValue

        Float newValue ->
            JE.float newValue

        _ ->
            JE.string ""
    )
