module Styles exposing (..)

import Html.Styled.Attributes exposing (css)
import Css exposing (..)


toolbarStyles =
    css
        [ border3 (px 1) solid (rgb 0 0 0)
        , padding (px 10)
        , left (px 0)
        , position absolute
        , right (px 527)
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
        , width (px 225)
        ]


listItemStyles =
    batch
        [ cursor pointer
        , padding2 (px 5) (px 10)
        , hover
            [ backgroundColor (hex "#ddd")
            ]
        ]


entityListStyles =
    css
        [ borderTop3 (px 1) solid (rgb 0 0 0)
        , flexGrow (num 1)
        , overflowY scroll
        ]


entityListItemStyles =
    css
        [ listItemStyles
        ]


entityListItemSelectedStyles =
    css
        [ listItemStyles
        , backgroundColor (hex "#ddd")
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
        , right (px 226)
        , top (px 0)
        , width (px 300)
        ]


componentListItemStyles =
    css
        [ listItemStyles
        ]


componentListItemSelectedStyles =
    css
        [ listItemStyles
        , backgroundColor (hex "#ddd")
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
        [ borderTop3 (px 1) solid (rgb 0 0 0)
        , displayFlex
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


paramStyle =
    css
        [ displayFlex
        , padding (px 5)
        ]


paramLabelStyle =
    css
        [ width (px 150)
        , flexShrink (num 0)
        ]


paramInputStyle =
    css
        [ width (pct 100)
        ]