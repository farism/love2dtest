module Scene exposing (..)

import Dict exposing (Dict)
import Entity exposing (Entity)


type alias Scene =
    { file : String
    , id : Int
    , name : String
    , width : Int
    , height : Int
    , entities : Dict String Entity
    , nextId : Int
    }
