module Shape exposing (Shape(..), init, decoder)

import Json.Decode as JD
import Vertex exposing (Vertex)


type Shape
    = Chain { loop : Bool, vertices : List Vertex }
    | Circle { radius : Int }
    | Edge { vertex1 : Vertex, vertex2 : Vertex }
    | Polygon { vertices : List Vertex }
    | Rectangle { width : Int, height : Int }


init : Shape
init =
    Rectangle { width = 32, height = 32 }


decoder : JD.Decoder Shape
decoder =
    JD.succeed init
