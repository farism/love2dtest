module Types exposing (..)

import Dict exposing (Dict)
import Json.Encode as JE


type alias Flags =
    { foo : String
    }


type alias FileIn =
    { name : String
    , contents : String
    }


type alias FileOut =
    { name : String
    , contents : JE.Value
    }


type alias Model =
    { nextId : Int
    , queuedComponent : Maybe Component
    , selectedComponent : Maybe String
    , selectedEntity : Maybe Entity
    , file : String
    , id : Int
    , name : String
    , entities : Dict String Entity
    }


type Msg
    = NoOp
    | OpenLevel
    | SaveLevel
    | SetId String
    | SetName String
    | AddEntity
    | RemoveEntity
    | AddComponent Component
    | RemoveComponent String
    | OpenLevelIn String
      -- | OpenLevelIn FileIn
    | SelectEntity Entity
    | SelectComponent Component
    | QueueComponent Component
    | UpdateComponent Component


type alias Level =
    { id : Int
    , name : String
    , entities : Dict String Entity
    }


type alias Entity =
    { id : Int
    , label : String
    , components : Dict String Component
    }


type alias Entity2 =
    { id : Int
    , label : String
    }


type alias Vector2 =
    { x : Int
    , y : Int
    }


type alias AbilityParams =
    {}


type alias AggressionParams =
    { x : Int
    , y : Int
    , width : Int
    , height : Int
    , duration : Int
    }


type alias AnimationParams =
    {}


type alias AttackParams =
    {}


type alias CheckpointParams =
    { index : Int
    }


type alias ContainerParams =
    {}


type alias DamageParams =
    { hitpoints : Int
    }


type alias FixtureParams =
    { x : Int
    , y : Int
    }


type alias HealthParams =
    { hitpoints : Int
    , armor : Int
    }


type alias InputParams =
    {}


type alias MovementParams =
    {}


type alias PlatformParams =
    { fall : Int
    , initialX : Int
    , initialY : Int
    }


type alias PlayerParams =
    { alias : String
    , money : Int
    , lives : Int
    , documents : Int
    , checkpoint : Int
    }


type alias PositionParams =
    { x : Int
    , y : Int
    }


type alias ProjectileParams =
    {}


type alias SnareParams =
    {}


type alias SoundParams =
    {}


type alias SpriteParams =
    { asset : String
    }


type alias TriggerParams =
    {}


type alias WaveParams =
    { type_ : String
    , x : Int
    , y : Int
    , amplitude : Float
    , frequency : Float
    }


type alias WaypointParams =
    { speed : Int
    , waypoints : List Vector2
    }


type Component
    = Ability AbilityParams
    | Aggression AggressionParams
    | Animation AnimationParams
    | Attack AttackParams
    | Checkpoint CheckpointParams
    | Container ContainerParams
    | Damage DamageParams
    | Fixture FixtureParams
    | Health HealthParams
    | Input InputParams
    | Movement MovementParams
    | Platform PlatformParams
    | Player PlayerParams
    | Position PositionParams
    | Projectile ProjectileParams
    | Snare SnareParams
    | Sound SoundParams
    | Sprite SpriteParams
    | Trigger TriggerParams
    | Wave WaveParams
    | Waypoint WaypointParams
