module Helpers exposing (..)

import Dict exposing (Dict)
import Json.Encode as JE


waveTypes : List String
waveTypes =
    [ "circular", "vertical", "horizontal" ]


is : a -> a -> Bool
is a b =
    a == b


strHead : List String -> String
strHead list =
    case list of
        head :: _ ->
            head

        [] ->
            ""


strToInt : Int -> String -> Int
strToInt default value =
    if value == "" then
        0
    else
        case String.toInt value of
            Nothing ->
                default

            Just int ->
                int


strToFloat : Float -> String -> Float
strToFloat default value =
    if value == "" then
        0
    else
        case String.toFloat value of
            Nothing ->
                default

            Just int ->
                int


dictEncoder : (a -> JE.Value) -> Dict b a -> JE.Value
dictEncoder encoder dict =
    Dict.toList dict
        |> List.map (\( k, v ) -> ( Debug.toString k, encoder v ))
        |> JE.object
