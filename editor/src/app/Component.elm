module Component exposing (..)

import Dict exposing (Dict)
import Json.Decode.Pipeline as JDE
import Json.Decode as JD
import Json.Encode as JE
import Fixture exposing (Fixture)
import Helpers exposing (dictEncoder)
import Vertex exposing (Vertex)


type alias Component =
    { id : String
    , fixture : Maybe Fixture
    , params : Dict String Param
    }


type ParamValue
    = String String
    | Int Int
    | Float Float
    | Bool Bool
    | List (List (Dict String Param))


type alias Param =
    { order : Int
    , options : Maybe (List String)
    , value : ParamValue
    }


decoder : JD.Decoder Component
decoder =
    JD.succeed Component
        |> JDE.required "id" JD.string
        |> JDE.optional "fixture" fixtureDecoder Nothing
        |> JDE.required "params" (JD.dict paramDecoder)


fixtureDecoder : JD.Decoder (Maybe Fixture)
fixtureDecoder =
    Fixture.decoder
        |> JD.andThen (\fixture -> JD.succeed (Just fixture))


paramDecoder : JD.Decoder Param
paramDecoder =
    JD.succeed Param
        |> JDE.required "order" JD.int
        |> JDE.optional "options" (JD.maybe (JD.list JD.string)) Nothing
        |> JDE.required "value" paramValueDecoder


paramValueDecoder : JD.Decoder ParamValue
paramValueDecoder =
    JD.oneOf
        [ JD.string |> JD.andThen (JD.succeed << String)
        , JD.int |> JD.andThen (JD.succeed << Int)
        , JD.float |> JD.andThen (JD.succeed << Float)
        , JD.bool |> JD.andThen (JD.succeed << Bool)
        ]


encoder : Component -> JE.Value
encoder { id, params } =
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
