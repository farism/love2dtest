module Types exposing (..)

import Dict exposing (Dict)
import Json.Encode as JE
import Draggable


type alias Flags =
    { foo : String
    }


type alias Model =
    { tree : Maybe TreeNode
    , selectedDirectory : String
    , selectedFile : String
    , queuedComponent : Maybe ( String, Component )
    , selectedComponent : Maybe ( String, Component )
    , selectedEntity : Maybe Entity
    , levelParseError : Maybe String
    , levelId : Int
    , levelName : String
    , entities : Dict String Entity
    , nextId :
        Int
        --
    , drag : Draggable.State ()
    , position : Point
    }


type Msg
    = NoOp
    | SelectProjectOut
    | SelectProjectIn String
    | LoadLevelOut String
    | LoadLevelIn ( String, String )
    | SaveLevel
    | SetLevelId String
    | SetLevelName String
    | AddEntity
    | RemoveEntity
    | SelectEntity Entity
    | SelectComponent ( String, Component )
    | AddComponent ( String, Component )
    | RemoveComponent String
    | UpdateComponent ( String, Component )
    | QueueComponent ( String, Component )
    | DragMsg (Draggable.Msg ())
    | OnDragBy Draggable.Delta


type alias DirectoryFields =
    { path : String
    , name : String
    , children : List TreeNode
    }


type alias FileFields =
    { path : String
    , name : String
    , extension : String
    }


type TreeNode
    = Directory DirectoryFields
    | File FileFields


type alias Level =
    { id : Int
    , name : String
    , entities : Dict String Entity
    }


type alias Entity =
    { id : Int
    , label : String
    , position : Point
    , components : Components
    }


type alias Point =
    { x : Float
    , y : Float
    }


type Param
    = IntParam Int
    | FloatParam Float
    | StringParam String


type alias Component =
    { id : String
    , params : Dict String Param
    }


type alias Components =
    Dict String Component



-- type alias AbilityParams =
--     {}
-- type alias AggressionParams =
--     { x : Int
--     , y : Int
--     , width : Int
--     , height : Int
--     , duration : Int
--     }
-- type alias AnimationParams =
--     {}
-- type alias AttackParams =
--     {}
-- type alias CheckpointParams =
--     { index : Int
--     }
-- type alias ContainerParams =
--     {}
-- type alias DamageParams =
--     { hitpoints : Int
--     }
-- type alias FixtureParams =
--     { x : Int
--     , y : Int
--     }
-- type alias HealthParams =
--     { hitpoints : Int
--     , armor : Int
--     }
-- type alias InputParams =
--     {}
-- type alias MovementParams =
--     {}
-- type alias PlatformParams =
--     { fall : Int
--     , initialX : Int
--     , initialY : Int
--     }
-- type alias PlayerParams =
--     { alias : String
--     , money : Int
--     , lives : Int
--     , documents : Int
--     , checkpoint : Int
--     }
-- type alias PositionParams =
--     { x : Int
--     , y : Int
--     }
-- type alias ProjectileParams =
--     {}
-- type alias SnareParams =
--     {}
-- type alias SoundParams =
--     {}
-- type alias SpriteParams =
--     { asset : String
--     }
-- type alias TriggerParams =
--     {}
-- type alias WaveParams =
--     { type_ : String
--     , x : Int
--     , y : Int
--     , amplitude : Float
--     , frequency : Float
--     }
-- type alias WaypointParams =
--     { speed : Int
--     , waypoints : List Point
--     }
-- type Component
--     = Ability AbilityParams
--     | Aggression AggressionParams
--     | Animation AnimationParams
--     | Attack AttackParams
--     | Checkpoint CheckpointParams
--     | Container ContainerParams
--     | Damage DamageParams
--     | Fixture FixtureParams
--     | Health HealthParams
--     | Input InputParams
--     | Movement MovementParams
--     | Platform PlatformParams
--     | Player PlayerParams
--     | Position PositionParams
--     | Projectile ProjectileParams
--     | Snare SnareParams
--     | Sound SoundParams
--     | Sprite SpriteParams
--     | Trigger TriggerParams
--     | Wave WaveParams
--     | Waypoint WaypointParams
