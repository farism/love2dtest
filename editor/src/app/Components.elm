module Components exposing (availableComponents)

import Dict exposing (Dict)
import Helpers exposing (..)
import Types exposing (..)


availableComponents : List Component
availableComponents =
    [ { id = "ability"
      , params = Dict.fromList []
      }
    , { id = "aggression"
      , params =
            Dict.fromList
                [ ( "x", Param 1 Nothing (IntValue 0) )
                , ( "y", Param 2 Nothing (IntValue 0) )
                , ( "width", Param 3 Nothing (IntValue 0) )
                , ( "height", Param 4 Nothing (IntValue 0) )
                , ( "duration", Param 5 Nothing (IntValue 0) )
                ]
      }
    , { id = "animation"
      , params = Dict.fromList []
      }
    , { id = "attack"
      , params = Dict.fromList []
      }
    , { id = "checkpoint"
      , params =
            Dict.fromList
                [ ( "index", Param 0 Nothing (IntValue 0) )
                ]
      }
    , { id = "container"
      , params = Dict.fromList []
      }
    , { id = "damage"
      , params =
            Dict.fromList
                [ ( "hitpoints", Param 0 Nothing (IntValue 0) )
                ]
      }
    , { id = "fixture"
      , params =
            Dict.fromList
                [ ( "density", Param 0 Nothing (FloatValue 0) )
                , ( "friction", Param 1 Nothing (FloatValue 0) )
                , ( "body", Param 2 Nothing (BodyValue defaultBody) )
                , ( "shape", Param 3 Nothing (ShapeValue defaultShape) )
                ]
      }
    , { id = "health"
      , params =
            Dict.fromList
                [ ( "hitpoints", Param 0 Nothing (IntValue 0) )
                , ( "armor", Param 0 Nothing (IntValue 0) )
                ]
      }
    , { id = "input"
      , params = Dict.fromList []
      }
    , { id = "movement"
      , params = Dict.fromList []
      }
    , { id = "platform"
      , params =
            Dict.fromList
                [ ( "fall", Param 0 Nothing (IntValue 0) )
                , ( "initialX", Param 0 Nothing (IntValue 0) )
                , ( "initialY", Param 0 Nothing (IntValue 0) )
                ]
      }
    , { id = "player"
      , params =
            Dict.fromList
                [ ( "alias", Param 0 Nothing (StringValue "") )
                , ( "money", Param 1 Nothing (IntValue 0) )
                , ( "lives", Param 2 Nothing (IntValue 0) )
                , ( "documents", Param 3 Nothing (IntValue 0) )
                , ( "checkpoint", Param 4 Nothing (IntValue 0) )
                ]
      }
    , { id = "position"
      , params =
            Dict.fromList
                [ ( "x", Param 0 Nothing (IntValue 0) )
                , ( "y", Param 0 Nothing (IntValue 0) )
                ]
      }
    , { id = "projectile"
      , params = Dict.fromList []
      }
    , { id = "snare"
      , params =
            Dict.fromList
                [ ( "strength", Param 0 Nothing (FloatValue 0) )
                ]
      }
    , { id = "sound"
      , params =
            Dict.fromList
                [ ( "asset", Param 0 Nothing (StringValue "") )
                ]
      }
    , { id = "sprite"
      , params =
            Dict.fromList
                [ ( "asset", Param 0 Nothing (StringValue "") )
                ]
      }
    , { id = "trigger"
      , params = Dict.fromList []
      }
    , { id = "waypoint"
      , params =
            Dict.fromList
                [ ( "speed", Param 0 Nothing (IntValue 0) )
                ]
      }
    , { id = "wave"
      , params =
            Dict.fromList
                [ ( "waveType", Param 0 (Just waveTypes) (StringValue (strHead waveTypes)) )
                , ( "x", Param 1 Nothing (IntValue 0) )
                , ( "y", Param 2 Nothing (IntValue 0) )
                , ( "amplitude", Param 3 Nothing (FloatValue 0) )
                , ( "frequency", Param 4 Nothing (FloatValue 0) )
                ]
      }
    ]
