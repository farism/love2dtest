module Styles exposing (..)

import Html.Styled exposing (Attribute)
import Html.Styled.Attributes exposing (css)
import Css exposing (..)
import Css.Global exposing (..)
import Vertex exposing (..)


colors =
    { grey0 = rgb 20 20 20
    , grey1 = rgb 30 30 30
    , grey2 = rgb 40 40 40
    , grey3 = rgb 50 50 50
    , grey4 = rgb 80 80 80
    , grey5 = rgb 100 100 100
    , grey6 = rgb 120 120 120
    , grey7 = rgb 140 140 140
    , grey8 = rgb 160 160 160
    , grey9 = rgb 180 180 180
    , white = rgb 255 255 255
    }


globalStyles =
    global
        [ each [ html, body ]
            [ backgroundColor colors.grey1
            , important (fontFamilies [ "Roboto", "sans-serif" ])
            , height (pct 100)
            , margin zero
            , minHeight (pct 100)
            , overflow hidden
            , padding zero
            ]
        , everything
            [ boxSizing borderBox
            , outline none
            ]
        , typeSelector "::-webkit-scrollbar"
            [ backgroundColor colors.grey3
            , borderLeft3 (px 1) solid colors.grey1
            , width (px 11)
            ]
        , typeSelector "::-webkit-scrollbar-thumb"
            [ backgroundClip contentBox
            , backgroundColor colors.grey5
            , border3 (px 2) solid transparent
            , borderLeftWidth (px 3)
            ]
        ]


buttonStyles =
    batch
        [ alignItems center
        , backgroundColor colors.grey2
        , border zero
        , color colors.grey9
        , cursor pointer
        , disabled
            [ cursor default
            , opacity (num 0.3)
            , hover
                [ backgroundColor transparent
                ]
            ]
        , display inlineFlex
        , height (px 36)
        , justifyContent center
        , lineHeight (px 36)
        , hover
            [ backgroundColor colors.grey3 ]
        , padding2 zero (px 15)
        ]


hrStyles =
    batch
        [ borderTop3 (px 1) solid colors.grey1
        ]


inputStyles =
    batch
        [ backgroundColor colors.grey2
        , border3 (px 1) solid colors.grey4
        , color colors.grey9
        , fontSize (px 13)
        , focus
            [ boxShadow4 zero zero (px 2) (hex "#e6faff")
            , border3 (px 1) solid (hex "#66a3ff")
            ]
        , outline none
        , height (px 24)
        , lineHeight (px 24)
        , padding2 zero (px 10)
        ]


inputNarrowStyles =
    batch
        [ width (px 75)
        ]


labelStyles =
    batch
        [ display inlineBlock
        , padding2 zero (px 15)
        ]


panelStyles =
    batch
        [ position absolute
        , backgroundColor colors.grey2
        , color colors.grey9
        ]


panelTitleStyles =
    css
        [ padding (px 10)
        , fontWeight bold
        ]


listItemStyles selected =
    batch
        [ cursor pointer
        , padding2 (px 5) (px 10)
        , if selected then
            backgroundColor colors.grey3
          else
            hover
                [ backgroundColor colors.grey3
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
        , backgroundColor colors.grey3
        , height (px 36)
        , left (px 175)
        , position absolute
        , right (px 400)
        , top zero
        , property "user-select" "none"
        ]


tabStyles selected =
    css
        [ alignItems center
        , if selected then
            batch
                [ backgroundColor colors.grey1
                , color colors.white
                , descendants
                    [ typeSelector "span"
                        [ opacity (num 1)
                        ]
                    ]
                ]
          else
            empty []
        , cursor pointer
        , descendants
            [ typeSelector "span"
                [ display inlineFlex
                , marginLeft (px 8)
                , opacity (num 0)
                ]
            ]
        , display inlineFlex
        , height (px 36)
        , hover
            [ descendants
                [ typeSelector "span"
                    [ opacity (num 1)
                    ]
                ]
            ]
        , lineHeight (px 36)
        , padding2 zero (px 15)
        ]


draggableStyles point =
    batch
        [ transform (translate2 (px point.x) (px point.y))
        , width (px 20)
        , height (px 20)
        , cursor move
        ]


sceneStyles =
    css
        [ bottom zero
        , left (px 175)
        , position absolute
        , right (px 400)
        , top (px 40)
        ]


sceneParamsStyles =
    css
        [ alignItems center
        , backgroundColor colors.grey1
        , color colors.grey9
        , displayFlex
        , height (px 40)
        , left zero
        , position absolute
        , right zero
        ]


sceneCanvasStyles =
    css
        [ bottom zero
        , displayFlex
        , alignItems center
        , left zero
        , justifyContent center
        , overflow hidden
        , position absolute
        , right zero
        , top (px 40)
        ]


sceneFrameStyles : Int -> Int -> Attribute msg
sceneFrameStyles w h =
    css
        [ border3 (px 1) solid colors.grey9
        , backgroundColor colors.grey0
        , minWidth (px (toFloat w))
        , minHeight (px (toFloat h))
        ]


sceneEntityStyles point =
    css
        [ draggableStyles point
        , backgroundColor colors.grey3
        , color colors.grey9
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
        [ flexGrow (num 1)
        , overflowY auto
        ]


selectedEntityStyles =
    css
        [ flexShrink (num 0)
        , padding (px 10)
        ]


entityInputStyles =
    css
        [ width (pct 100)
        ]


componentManagerStyles =
    css
        [ panelStyles
        , borderRight3 (px 1) solid colors.grey1
        , displayFlex
        , flexDirection column
        , height (pct 100)
        , position absolute
        , right (px 150)
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
        [ flexGrow (num 1)
        , overflowY auto
        ]


selectedComponentsStyles =
    css
        [ displayFlex
        , flexDirection column
        , flex (num 2)
        ]


selectedComponentsListStyles =
    css
        [ flexGrow (num 1)
        , overflowY auto
        ]


selectedComponentStyles =
    css
        [ flexShrink (num 0)
        , padding (px 10)
        ]


componentParamInputStyles =
    css
        [ alignItems center
        , descendants
            [ typeSelector "span"
                [ flex (num 1)
                , fontSize (px 13)
                ]
            ]
        , displayFlex
        , marginTop (px 5)
        ]
