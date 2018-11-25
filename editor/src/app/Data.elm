module Data exposing (availableComponents)

import Dict exposing (Dict)
import Component exposing (Component, Param, ParamValue(..))
import Fixture exposing (Fixture)
import Helpers exposing (strHead)


waveTypes : List String
waveTypes =
    [ "circular", "vertical", "horizontal" ]


availableComponents : List Component
availableComponents =
    [ { id = "ability"
      , fixture = Nothing
      , params = Dict.fromList []
      }
    , { id = "aggression"
      , fixture = Nothing
      , params =
            Dict.fromList
                [ ( "x", Param 1 Nothing (Int 0) )
                , ( "y", Param 2 Nothing (Int 0) )
                , ( "width", Param 3 Nothing (Int 0) )
                , ( "height", Param 4 Nothing (Int 0) )
                , ( "duration", Param 5 Nothing (Int 0) )
                ]
      }
    , { id = "animation"
      , fixture = Nothing
      , params = Dict.fromList []
      }
    , { id = "attack"
      , fixture = Nothing
      , params = Dict.fromList []
      }
    , { id = "checkpoint"
      , fixture = Nothing
      , params =
            Dict.fromList
                [ ( "index", Param 0 Nothing (Int 0) )
                ]
      }
    , { id = "container"
      , fixture = Nothing
      , params = Dict.fromList []
      }
    , { id = "damage"
      , fixture = Nothing
      , params =
            Dict.fromList
                [ ( "hitpoints", Param 0 Nothing (Int 0) )
                ]
      }
    , { id = "fixture"
      , fixture = Just Fixture.init
      , params =
            Dict.fromList
                [ ( "density", Param 0 Nothing (Float 0) )
                , ( "friction", Param 1 Nothing (Float 0) )
                ]
      }
    , { id = "health"
      , fixture = Nothing
      , params =
            Dict.fromList
                [ ( "hitpoints", Param 0 Nothing (Int 0) )
                , ( "armor", Param 0 Nothing (Int 0) )
                ]
      }
    , { id = "input"
      , fixture = Nothing
      , params = Dict.fromList []
      }
    , { id = "movement"
      , fixture = Nothing
      , params = Dict.fromList []
      }
    , { id = "platform"
      , fixture = Nothing
      , params =
            Dict.fromList
                [ ( "fall", Param 0 Nothing (Int 0) )
                , ( "initialX", Param 0 Nothing (Int 0) )
                , ( "initialY", Param 0 Nothing (Int 0) )
                ]
      }
    , { id = "player"
      , fixture = Nothing
      , params =
            Dict.fromList
                [ ( "alias", Param 0 Nothing (String "") )
                , ( "money", Param 1 Nothing (Int 0) )
                , ( "lives", Param 2 Nothing (Int 0) )
                , ( "documents", Param 3 Nothing (Int 0) )
                , ( "checkpoint", Param 4 Nothing (Int 0) )
                ]
      }
    , { id = "position"
      , fixture = Nothing
      , params =
            Dict.fromList
                [ ( "x", Param 0 Nothing (Int 0) )
                , ( "y", Param 0 Nothing (Int 0) )
                ]
      }
    , { id = "projectile"
      , fixture = Nothing
      , params = Dict.fromList []
      }
    , { id = "snare"
      , fixture = Nothing
      , params =
            Dict.fromList
                [ ( "strength", Param 0 Nothing (Float 0) )
                ]
      }
    , { id = "sound"
      , fixture = Nothing
      , params =
            Dict.fromList
                [ ( "asset", Param 0 Nothing (String "") )
                ]
      }
    , { id = "sprite"
      , fixture = Nothing
      , params =
            Dict.fromList
                [ ( "asset", Param 0 Nothing (String "") )
                ]
      }
    , { id = "trigger"
      , fixture = Nothing
      , params = Dict.fromList []
      }
    , { id = "waypoint"
      , fixture = Nothing
      , params =
            Dict.fromList
                [ ( "speed", Param 0 Nothing (Int 0) )
                ]
      }
    , { id = "wave"
      , fixture = Nothing
      , params =
            Dict.fromList
                [ ( "waveType", Param 0 (Just waveTypes) (String (strHead waveTypes)) )
                , ( "x", Param 1 Nothing (Int 0) )
                , ( "y", Param 2 Nothing (Int 0) )
                , ( "amplitude", Param 3 Nothing (Float 0) )
                , ( "frequency", Param 4 Nothing (Float 0) )
                ]
      }
    ]
