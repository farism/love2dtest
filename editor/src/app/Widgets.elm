module Widgets exposing (button, hr, input, select)

import Html.Styled exposing (Attribute, Html, styled)
import Helpers exposing (onBlur, onEnter, strToInt)
import Styles exposing (..)


button : List (Attribute msg) -> List (Html msg) -> Html msg
button =
    styled Html.Styled.button [ buttonStyles ]


hr : Html msg
hr =
    (styled Html.Styled.div [ hrStyles ]) [] []


input : List (Attribute msg) -> List (Html msg) -> Html msg
input =
    styled Html.Styled.input [ inputStyles ]


select : List (Attribute msg) -> List (Html msg) -> Html msg
select =
    styled Html.Styled.select [ inputStyles ]
