module Types exposing (..)

import Dict exposing (Dict)
import Draggable
import Json.Encode as JE
import Keyboard exposing (Key, RawKey)
import UndoList exposing (UndoList)


type alias Flags =
    {}


type alias UndoModel =
    UndoList Model


type alias Model =
    { tree : Maybe TreeNode
    , selectedFile : String
    , queuedComponent : Maybe Component
    , selectedComponent : Maybe String
    , selectedEntity : Maybe Int
    , levelParseError : Maybe String
    , levelId : Int
    , levelName : String
    , entities : Dict String Entity
    , nextId : Int
    }


type Msg
    = Undo
    | Redo
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
    | SelectComponent Component
    | AddComponent Component
    | RemoveComponent String
    | UpdateParam String String Param String
    | UpdateBody Body
    | QueueComponent Component
    | DragMsg Entity (Draggable.Msg ())
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
    , components : Dict String Component
    , dragpoint : Vertex
    , drag : Draggable.State ()
    }


type alias Vertex =
    { x : Float
    , y : Float
    }


type alias Component =
    { id : String
    , params : Dict String Param
    }


type ParamValue
    = StringValue String
    | IntValue Int
    | FloatValue Float
    | BoolValue Bool
    | BodyValue Body
    | ShapeValue Shape
    | JointValue Joint
    | ParamList (List (Dict String Param))


type alias Param =
    { order : Int
    , options : Maybe (List String)
    , value : ParamValue
    }


type alias Fixture =
    { body : Body
    , shape : Shape
    , density : Float
    , friction : Float
    }


type BodyType
    = Static
    | Dynamic
    | Kinematic


type alias Body =
    { bodyType : BodyType
    , category : List Int
    , mask : List Int
    , x : Float
    , y : Float
    }


type Shape
    = Chain { loop : Bool, vertices : List Vertex }
    | Circle { radius : Int }
    | Edge { vertex1 : Vertex, vertex2 : Vertex }
    | Polygon { vertices : List Vertex }
    | Rectangle { width : Int, height : Int }


type alias BasicJointFields a =
    { a
        | body1 : Body
        , body2 : Body
        , vertex1 : Vertex
        , vertex2 : Vertex
        , collide : Bool
    }


type Joint
    = Distance (BasicJointFields {})
    | Friction (BasicJointFields {})
    | Prismatic (BasicJointFields { axis : Vertex })
    | Pulley (BasicJointFields { ground1 : Vertex, ground2 : Vertex, ratio : Float })
    | Revolute (BasicJointFields { referenceAngle : Float })
    | Rope (BasicJointFields { maxLength : Int })
    | Weld (BasicJointFields { axis : Vertex })
    | Wheel (BasicJointFields {})
      -- special
    | Gear { joint1 : Joint, joint2 : Joint, ratio : Float }
    | Motor { body1 : Body, body2 : Body, correctionFactor : Float }
    | Mouse { body : Body, vertex : Vertex }
