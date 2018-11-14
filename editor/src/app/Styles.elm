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
        , position absolute
        , right (px 0)
        , top (px 0)
        , width (px 199)
        ]


entityListStyles =
    css
        [ borderTop3 (px 1) solid (rgb 0 0 0)
        , flexGrow (num 1)
        , overflowY scroll
        ]


entityListItemStyles =
    css
        [ cursor pointer
        , hover [ backgroundColor (hex "#ddd") ]
        , padding2 (px 5) (px 10)
        ]


selectedEntityStyles =
    css
        [ flexShrink (num 0)
        , borderTop3 (px 1) solid (rgb 0 0 0)
        ]


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


componentListItemStyles =
    css
        [ cursor pointer
        , hover [ backgroundColor (hex "#ddd") ]
        , padding2 (px 5) (px 10)
        ]


availableComponentsStyles =
    css
        [ displayFlex
        , flexDirection column
        , flex (num 1)
        ]


availableComponentsListStyles =
    css
        [ borderTop3 (px 1) solid (rgb 0 0 0)
        , flexGrow (num 1)
        , overflowY scroll
        ]


selectedComponentsStyles =
    css
        [ displayFlex
        , flexDirection column
        , flex (num 1)
        ]


selectedComponentsListStyles =
    css
        [ borderTop3 (px 1) solid (rgb 0 0 0)
        , flexGrow (num 1)
        , overflowY scroll
        ]


selectedComponentStyles =
    css
        [ borderTop3 (px 1) solid (rgb 0 0 0)
        , flexShrink (num 0)
        ]
