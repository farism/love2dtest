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
    | SelectComponent Component
    | AddComponent Component
    | RemoveComponent String
    | UpdateComponent String String Param String
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
    , dragpoint : Point
    , drag : Draggable.State ()
    }


type alias Point =
    { x : Float
    , y : Float
    }


type ParamType
    = String
    | Int
    | Float
    | Bool


type alias Param =
    { order : Int
    , paramType : ParamType
    , options : Maybe (List String)
    , value : String
    }


type alias Component =
    { id : String
    , params : Dict String Param
    }
