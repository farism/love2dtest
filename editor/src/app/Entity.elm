module Entity exposing (..)

import Dict exposing (Dict)
import Draggable
import Component exposing (Component)
import Vertex exposing (..)


type alias Entity =
    { id : Int
    , label : String
    , components : Dict String Component
    , dragVertex : Vertex
    , drag : Draggable.State ()
    }
