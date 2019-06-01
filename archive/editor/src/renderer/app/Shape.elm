module Shape exposing (Shape(..), ShapeMsg(..), decoder, init, shapeTypes, strToType, typeToStr, update)

import Helpers exposing (strToInt)
import Json.Decode as JD
import Vertex exposing (Vertex)


type Shape
    = Chain { loop : Bool, vertices : List Vertex }
    | Circle { radius : Int }
    | Edge { vertex1 : Vertex, vertex2 : Vertex }
    | Polygon { vertices : List Vertex }
    | Rectangle { width : Int, height : Int }


type ShapeMsg
    = Replace String
    | SetChainLoop Bool
    | SetChainVertices String
    | SetCircleRadius String
    | SetEdgeVertex1 String
    | SetEdgeVertex2 String
    | SetPolygonVertices String
    | SetRectangleWidth String
    | SetRectangleHeight String


shapeTypes : List String
shapeTypes =
    List.map typeToStr [ initChain, initCircle, initEdge, initPolygon, initRectangle ]


typeToStr : Shape -> String
typeToStr shape =
    case shape of
        Chain _ ->
            "chain"

        Circle _ ->
            "circle"

        Edge _ ->
            "edge"

        Polygon _ ->
            "polygon"

        Rectangle _ ->
            "rectangle"


strToType : String -> Shape
strToType shape =
    case shape of
        "chain" ->
            initChain

        "circle" ->
            initCircle

        "edge" ->
            initEdge

        "polygon" ->
            initPolygon

        "rectangle" ->
            initRectangle

        _ ->
            initRectangle


init : Shape
init =
    initRectangle


initChain : Shape
initChain =
    Chain { loop = False, vertices = [] }


initCircle : Shape
initCircle =
    Circle { radius = 0 }


initEdge : Shape
initEdge =
    Edge { vertex1 = (Vertex 0 0), vertex2 = (Vertex 0 0) }


initPolygon : Shape
initPolygon =
    Polygon { vertices = [] }


initRectangle : Shape
initRectangle =
    Rectangle { width = 0, height = 0 }


update : ShapeMsg -> Shape -> Shape
update msg shape =
    case ( shape, msg ) of
        ( _, Replace value ) ->
            strToType value

        ( Chain params, SetChainLoop value ) ->
            Chain { params | loop = value }

        ( Chain params, SetChainVertices value ) ->
            shape

        ( Circle params, SetCircleRadius value ) ->
            Circle { params | radius = strToInt params.radius value }

        ( Edge params, SetEdgeVertex1 value ) ->
            shape

        ( Edge params, SetEdgeVertex2 value ) ->
            shape

        ( Polygon params, SetPolygonVertices value ) ->
            shape

        ( Rectangle params, SetRectangleWidth value ) ->
            Rectangle { params | width = strToInt params.width value }

        ( Rectangle params, SetRectangleHeight value ) ->
            Rectangle { params | height = strToInt params.height value }

        _ ->
            shape


decoder : JD.Decoder Shape
decoder =
    JD.succeed init
