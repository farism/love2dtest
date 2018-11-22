module Fixture exposing (Fixture, init, decoder)

import Json.Decode as JD
import Body exposing (Body)
import Shape exposing (Shape)


type alias Fixture =
    { body : Body
    , shape : Shape
    , density : Float
    , friction : Float
    }


init : Fixture
init =
    { body = Body.init
    , shape = Shape.init
    , density = 1
    , friction = 1
    }


decoder : JD.Decoder Fixture
decoder =
    JD.map4 Fixture
        (JD.field "body" Body.decoder)
        (JD.field "shape" Shape.decoder)
        (JD.field "density" JD.float)
        (JD.field "friction" JD.float)
