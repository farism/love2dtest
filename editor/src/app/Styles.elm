module Styles exposing (..)

import Html.Styled.Attributes exposing (css)
import Css exposing (..)
import Vertex exposing (..)


grey1 =
    hex "#1e1e1e"


grey2 =
    hex "#252525"


grey3 =
    hex "#2d2d2d"


grey4 =
    hex "#373737"


grey10 =
    hex "#ccc"


panelStyles =
    batch
        [ position absolute
        , backgroundColor grey2
        , color grey10
        ]


listItemStyles selected =
    batch
        [ cursor pointer
        , padding2 (px 5) (px 10)
        , if selected then
            backgroundColor grey3
          else
            hover
                [ backgroundColor grey3
                ]
        ]


treeFileItemStyles selected depth =
    css
        [ listItemStyles selected
        , paddingLeft (px (toFloat depth * 10))
        ]


entityListItemStyles selected =
    css
        [ listItemStyles selected
        ]


componentListItemStyles selected =
    css
        [ listItemStyles selected ]


tabsListStyles =
    css
        [ panelStyles
        , backgroundColor grey3
        , height (px 40)
        , left (px 175)
        , position absolute
        , right (px 150)
        , top zero
        ]


tabStyles selected =
    css
        [ cursor pointer
        , display inlineBlock
        , height (px 40)
        , lineHeight (px 40)
        , padding2 zero (px 15)
        , if selected then
            backgroundColor grey1
          else
            empty []
        ]


draggableStyles point =
    css
        [ transform (translate2 (px point.x) (px point.y))
        , width (px 20)
        , height (px 20)
        , cursor move
        ]


sceneStyles =
    css
        [ bottom zero
        , left (px 170)
        , padding (px 10)
        , position absolute
        , right (px 402)
        , top (px 61)
        , backgroundColor (hex "#ccc")
        ]


toolbarStyles =
    css
        [ left zero
        , padding (px 10)
        , position absolute
        , right (px 402)
        , top zero
        ]


treeStyles =
    css
        [ panelStyles
        , bottom zero
        , left zero
        , overflowY auto
        , padding2 (px 10) zero
        , position absolute
        , top zero
        , width (px 175)
        ]


treeDirectoryItemStyles depth =
    css
        [ padding2 (px 5) (px 10)
        , paddingLeft (px (toFloat (depth + 1) * 10))
        , cursor default
        ]


entityManagerStyles =
    css
        [ panelStyles
        , bottom zero
        , displayFlex
        , flexDirection column
        , right zero
        , top zero
        , width (px 150)
        ]


entityListStyles =
    css
        [ borderTop3 (px 1) solid (rgb 0 0 0)
        , flexGrow (num 1)
        , overflowY auto
        ]


selectedEntityStyles =
    css
        [ borderTop3 (px 1) solid (rgb 0 0 0)
        , flexShrink (num 0)
        ]


componentManagerStyles =
    css
        [ displayFlex
        , flexDirection column
        , height (pct 100)
        , position absolute
        , right (px 151)
        , top zero
        , width (px 250)
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
