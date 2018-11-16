module Styles exposing (..)

import Html.Styled.Attributes exposing (css)
import Css exposing (..)
import Types exposing (..)


listItemStyles =
    batch
        [ cursor pointer
        , padding2 (px 5) (px 10)
        , hover
            [ backgroundColor (hex "#ddd")
            ]
        ]


draggableStyles point =
    css
        [ transform (translate2 (px point.x) (px point.y))
        , width (px 20)
        , height (px 20)
        , backgroundColor (hex "#0f0")
        ]


sceneStyles =
    css
        [ bottom (px 0)
        , left (px 170)
        , padding (px 10)
        , position absolute
        , right (px 402)
        , top (px 61)
        , backgroundColor (hex "#f00")
        ]


toolbarStyles =
    css
        [ border3 (px 1) solid (rgb 0 0 0)
        , left (px 0)
        , padding (px 10)
        , position absolute
        , right (px 402)
        , top (px 0)
        ]


treeStyles =
    css
        [ border3 (px 1) solid (rgb 0 0 0)
        , bottom (px 0)
        , left (px 0)
        , padding (px 10)
        , overflow scroll
        , position absolute
        , top (px 61)
        , width (px 150)
        ]


treeDirectoryItemStyles depth =
    css
        [ padding2 (px 5) (px 10)
        , paddingLeft (px (toFloat depth * 10))
        ]


treeFileItemStyles depth =
    css
        [ listItemStyles
        , paddingLeft (px (toFloat depth * 10))
        ]


treeFileItemSelectedStyles depth =
    css
        [ backgroundColor (hex "#ddd")
        , listItemStyles
        , paddingLeft (px (toFloat depth * 10))
        ]


entityManagerStyles =
    css
        [ border3 (px 1) solid (rgb 0 0 0)
        , bottom (px 0)
        , displayFlex
        , flexDirection column
        , position absolute
        , right (px 0)
        , top (px 0)
        , width (px 150)
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
        [ backgroundColor (hex "#ddd")
        , listItemStyles
        ]


selectedEntityStyles =
    css
        [ borderTop3 (px 1) solid (rgb 0 0 0)
        , flexShrink (num 0)
        ]


componentManagerStyles =
    css
        [ border3 (px 1) solid (rgb 0 0 0)
        , displayFlex
        , flexDirection column
        , height (pct 100)
        , position absolute
        , right (px 151)
        , top (px 0)
        , width (px 250)
        ]


componentListItemStyles =
    css
        [ listItemStyles
        ]


componentListItemSelectedStyles =
    css
        [ backgroundColor (hex "#ddd")
        , listItemStyles
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
