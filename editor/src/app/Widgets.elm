module Widgets exposing (button, checkbox, hr, input, select)

import Html.Styled exposing (Attribute, Html, styled)
import Html.Styled.Attributes exposing (css, type_)
import Helpers exposing (onBlur, onEnter, strToInt)
import Styles exposing (..)


checkbox : List (Attribute msg) -> List (Html msg) -> Html msg
checkbox attributes children =
    Html.Styled.label []
        [ Html.Styled.input
            ([ css [ checkboxStyles ], type_ "checkbox" ] ++ attributes)
            []
        , Html.Styled.span
            []
            children
        ]


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
    styled Html.Styled.select [ selectStyles ]
