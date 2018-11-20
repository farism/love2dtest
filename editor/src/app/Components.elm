module Components exposing (..)

import Dict exposing (Dict)
import Types exposing (..)


availableComponents : List Component
availableComponents =
    [ { id = "player"
      , params =
            Dict.fromList
                [ ( "alias", Param 0 String Nothing "" )
                , ( "money", Param 1 Int Nothing "0" )
                , ( "lives", Param 2 Int Nothing "0" )
                , ( "documents", Param 3 Int Nothing "0" )
                , ( "checkpoint", Param 4 Int Nothing "0" )
                ]
      }
    , { id = "wave"
      , params =
            Dict.fromList
                [ ( "waveType", Param 0 String (Just [ "circular", "vertical", "horizontal" ]) "circular" )
                , ( "x", Param 1 Int Nothing "0" )
                , ( "y", Param 2 Int Nothing "0" )
                , ( "amplitude", Param 3 Float Nothing "0" )
                , ( "frequency", Param 4 Float Nothing "0" )
                ]
      }
    ]
