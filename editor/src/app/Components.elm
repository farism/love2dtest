module Components exposing (..)

import Dict exposing (Dict)
import Types exposing (..)


availableComponents : List Component
availableComponents =
    [ { id = "player"
      , params =
            Dict.fromList
                [ ( "alias", { paramType = String, order = 0, value = "" } )
                , ( "money", { paramType = Int, order = 1, value = "0" } )
                , ( "lives", { paramType = Int, order = 2, value = "0" } )
                , ( "documents", { paramType = Int, order = 3, value = "0" } )
                , ( "checkpoint", { paramType = Int, order = 4, value = "0" } )
                ]
      }
    , { id = "wave"
      , params =
            Dict.fromList
                [ ( "waveType", { paramType = Options [ "circular", "vertical", "horizontal" ], order = 0, value = "circular" } )
                , ( "x", { paramType = Int, order = 1, value = "0" } )
                , ( "y", { paramType = Int, order = 2, value = "0" } )
                , ( "amplitude", { paramType = Float, order = 3, value = "0" } )
                , ( "frequency", { paramType = Float, order = 4, value = "0" } )
                ]
      }
    ]
