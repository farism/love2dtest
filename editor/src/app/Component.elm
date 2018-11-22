module Component exposing (..)

import Dict exposing (Dict)
import Vertex exposing (..)


type alias Component =
    { id : String
    , fixture : Maybe Fixture
    , params : Dict String Param
    }


type ParamValue
    = String String
    | Int Int
    | Float Float
    | Bool Bool
    | List (List (Dict String Param))


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
    | Gear { joint1 : Joint, joint2 : Joint, ratio : Float }
    | Motor { body1 : Body, body2 : Body, correctionFactor : Float }
    | Mouse { body : Body, vertex : Vertex }
    | Prismatic (BasicJointFields { axis : Vertex })
    | Pulley (BasicJointFields { ground1 : Vertex, ground2 : Vertex, ratio : Float })
    | Revolute (BasicJointFields { referenceAngle : Float })
    | Rope (BasicJointFields { maxLength : Int })
    | Weld (BasicJointFields { axis : Vertex })
    | Wheel (BasicJointFields {})
