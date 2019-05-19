module Component exposing (Component, encoder, decoder)

import Dict exposing (Dict)
import Fixture exposing (Fixture)
import Helpers exposing (dictEncoder)
import Json.Decode as JD
import Json.Decode.Pipeline as JDE
import Json.Encode as JE
import Param exposing (Param)
import Vertex exposing (Vertex)


type alias Component =
    { id : String
    , fixture : Maybe Fixture
    , params : Dict String Param
    }


decoder : JD.Decoder Component
decoder =
    JD.succeed Component
        |> JDE.required "id" JD.string
        |> JDE.optional "fixture" fixtureDecoder Nothing
        |> JDE.required "params" (JD.dict Param.decoder)


encoder : Component -> JE.Value
encoder { id, params } =
    JE.object
        [ ( "id", JE.string id )
        , ( "params", dictEncoder Param.encoder params )
        ]


fixtureDecoder : JD.Decoder (Maybe Fixture)
fixtureDecoder =
    Fixture.decoder
        |> JD.andThen (\fixture -> JD.succeed (Just fixture))
