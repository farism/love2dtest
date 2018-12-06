module Fixture exposing (Fixture, FixtureMsg(..), decoder, init, update)

import Json.Decode as JD
import Body exposing (Body, BodyMsg)
import Helpers exposing (strToFloat)
import Shape exposing (Shape, ShapeMsg)


type alias Fixture =
    { body : Body
    , shape : Shape
    , density : Float
    , friction : Float
    }


type FixtureMsg
    = BodyMsg BodyMsg
    | SetDensity String
    | SetFriction String
    | ShapeMsg ShapeMsg


init : Fixture
init =
    { body = Body.init
    , shape = Shape.init
    , density = 1
    , friction = 1
    }


update : FixtureMsg -> Fixture -> Fixture
update msg fixture =
    case msg of
        BodyMsg bodyMsg ->
            { fixture | body = Body.update bodyMsg fixture.body }

        SetDensity value ->
            { fixture | density = strToFloat fixture.density value }

        SetFriction value ->
            { fixture | friction = strToFloat fixture.friction value }

        ShapeMsg shapeMsg ->
            { fixture | shape = Shape.update shapeMsg fixture.shape }


decoder : JD.Decoder Fixture
decoder =
    JD.map4 Fixture
        (JD.field "body" Body.decoder)
        (JD.field "shape" Shape.decoder)
        (JD.field "density" JD.float)
        (JD.field "friction" JD.float)
