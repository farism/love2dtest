module Joint exposing (Joint(..))

import Body exposing (Body)
import Vertex exposing (Vertex)


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
