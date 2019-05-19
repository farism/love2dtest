module Helpers exposing (..)

import Dict exposing (Dict)
import FontAwesome.Attributes as Icon
import FontAwesome.Solid as Icon
import Html
import Html.Styled
import Html.Styled.Attributes
import Html.Styled.Events
import Json.Decode as JD
import Json.Encode as JE
import List.Extra
import Svg


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
        Maybe.withDefault default (String.toInt value)


strToFloat : Float -> String -> Float
strToFloat default value =
    if value == "" then
        0
    else
        Maybe.withDefault default (String.toFloat value)


dictEncoder : (a -> JE.Value) -> Dict b a -> JE.Value
dictEncoder encoder dict =
    Dict.toList dict
        |> List.map (\( k, v ) -> ( Debug.toString k, encoder v ))
        |> JE.object


onBlur : (String -> msg) -> Html.Styled.Attribute msg
onBlur handler =
    Html.Styled.Events.on
        "blur"
        (JD.map handler Html.Styled.Events.targetValue)


onEnter : (String -> msg) -> Html.Styled.Attribute msg
onEnter msg =
    let
        isEnter code =
            if code == 13 then
                JD.succeed ""
            else
                JD.fail ""

        decodeEnter =
            JD.andThen isEnter Html.Styled.Events.keyCode
    in
        Html.Styled.Events.on "keydown" <|
            JD.map2
                (\_ value -> msg value)
                decodeEnter
                Html.Styled.Events.targetValue


commaDelimited : List Int -> String
commaDelimited list =
    String.join "," <| List.map String.fromInt list


pathKey : List String -> String
pathKey list =
    Maybe.withDefault "" (List.Extra.last list)
