module Vertex exposing (Vertex, init, decoder, encoder)

import Json.Decode as JD
import Json.Encode as JE


type alias Vertex =
    { x : Float
    , y : Float
    }


init : Vertex
init =
    Vertex 0 0


decoder : JD.Decoder Vertex
decoder =
    JD.map2 Vertex
        (JD.field "x" JD.float)
        (JD.field "y" JD.float)


encoder : Vertex -> JE.Value
encoder { x, y } =
    JE.object
        [ ( "x", JE.float x )
        , ( "y", JE.float y )
        ]
