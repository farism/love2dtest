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


entityManagerStyles =
    css
        [ displayFlex
        , border3 (px 1) solid (rgb 0 0 0)
        , bottom (px 50)
        , flexDirection column
        , overflowY scroll
        , position absolute
        , right (px 0)
        , top (px 0)
        , width (px 199)
        ]


entityListStyles =
    css
        [ flexGrow (num 1) ]


selectedEntityStyles =
    css
        [ flexShrink (num 0) ]


componentManagerStyles =
    css
        [ displayFlex
        , flexDirection column
        , border3 (px 1) solid (rgb 0 0 0)
        , height (pct 100)
        , position absolute
        , right (px 200)
        , top (px 0)
        , width (px 200)
        ]


availableComponentsStyles =
    css
        [ displayFlex
        , flexDirection column
        , flex none
        , height (pct 50)
        ]


selectedComponentsStyles =
    css
        [ flex none
        , height (pct 50)
        ]
