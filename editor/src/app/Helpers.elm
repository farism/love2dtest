module Helpers exposing (..)

import Dict exposing (Dict)
import Json.Decode as JD
import Json.Encode as JE
import Html.Styled
import Html.Styled.Events exposing (keyCode, on, targetValue)


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


onBlur : (String -> msg) -> Html.Styled.Attribute msg
onBlur handler =
    on "blur" (JD.map handler targetValue)


onEnter : (String -> msg) -> Html.Styled.Attribute msg
onEnter msg =
    let
        isEnter code =
            if code == 13 then
                JD.succeed ""
            else
                JD.fail ""

        decodeEnter =
            JD.andThen isEnter keyCode
    in
        on "keydown" <|
            JD.map2
                (\_ value -> msg value)
                decodeEnter
                targetValue
