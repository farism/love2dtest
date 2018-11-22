module Helpers exposing (..)

import Dict
import Draggable
import Component exposing (..)
import Entity exposing (..)
import Vertex exposing (..)


-- constants


waveTypes : List String
waveTypes =
    [ "circular", "vertical", "horizontal" ]


bodyTypes : List String
bodyTypes =
    [ "static", "dynamic", "kinematic" ]



-- general


is : a -> a -> Bool
is a b =
    a == b


getKey : List String -> String
getKey path =
    case path of
        head :: _ ->
            head

        [] ->
            ""



-- strings


strHead : List String -> String
strHead list =
    (case list of
        h :: _ ->
            h

        _ ->
            ""
    )


strToInt : String -> Int
strToInt value =
    if value == "" then
        0
    else
        case String.toInt value of
            Nothing ->
                0

            Just int ->
                int


strToFloat : String -> Float
strToFloat value =
    if value == "" then
        0
    else
        case String.toFloat value of
            Nothing ->
                0

            Just int ->
                int



-- converters


fromBodyType : BodyType -> String
fromBodyType bodyType =
    case bodyType of
        Static ->
            "static"

        Dynamic ->
            "dynamic"

        Kinematic ->
            "kinematic"


toBodyType : String -> BodyType
toBodyType bodyType =
    case bodyType of
        "static" ->
            Static

        "dynamic" ->
            Dynamic

        "kinematic" ->
            Kinematic

        _ ->
            Static



-- factories


defaultEntity : Int -> Entity
defaultEntity id =
    { id = id
    , label = ""
    , components = Dict.empty
    , dragVertex = Vertex 0 0
    , drag = Draggable.init
    }


defaultFixture : Fixture
defaultFixture =
    { friction = 1
    , density = 1
    , body = defaultBody
    , shape = defaultShape
    }


defaultBody : Body
defaultBody =
    { bodyType = Static
    , category = []
    , mask = []
    , x = 0
    , y = 0
    }


defaultShape : Shape
defaultShape =
    Rectangle { width = 32, height = 32 }
