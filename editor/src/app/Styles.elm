module Styles exposing (..)

import Html.Styled.Attributes exposing (css)
import Css exposing (..)


toolbarStyles =
    css
        [ border3 (px 1) solid (rgb 0 0 0)
        , padding (px 10)
        , left (px 0)
        , position absolute
        , right (px 401)
        , top (px 0)
        ]


entityListStyles =
    css
        [ border3 (px 1) solid (rgb 0 0 0)
        , height (pct 100)
        , overflowY scroll
        , position absolute
        , right (px 0)
        , top (px 0)
        , width (px 199)
        ]


componentListStyles =
    css
        [ border3 (px 1) solid (rgb 0 0 0)
        , height (pct 100)
        , position absolute
        , right (px 200)
        , top (px 0)
        , width (px 200)
        ]
