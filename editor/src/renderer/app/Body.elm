module Body exposing (Body, BodyMsg(..), bodyTypes, decoder, init, strToType, typeToStr, update)

import Helpers exposing (strToFloat)
import Json.Decode as JD
import List.Extra as List


type alias Body =
    { bodyType : BodyType
    , category : List Int
    , mask : List Int
    , x : Float
    , y : Float
    }


type BodyMsg
    = SetBodyType String
    | SetBodyCategory String
    | SetBodyMask String
    | SetBodyX String
    | SetBodyY String


type BodyType
    = Static
    | Dynamic
    | Kinematic


bodyTypes : List String
bodyTypes =
    List.map typeToStr [ Static, Dynamic, Kinematic ]


init : Body
init =
    { bodyType = Static
    , category = []
    , mask = []
    , x = 0
    , y = 0
    }


update : BodyMsg -> Body -> Body
update msg body =
    case msg of
        SetBodyType value ->
            { body | bodyType = strToType value }

        SetBodyCategory value ->
            { body | category = strToCategoryList value }

        SetBodyMask value ->
            { body | mask = strToCategoryList value }

        SetBodyX value ->
            { body | x = strToFloat body.x value }

        SetBodyY value ->
            { body | y = strToFloat body.y value }


typeToStr : BodyType -> String
typeToStr bodyType =
    case bodyType of
        Static ->
            "static"

        Dynamic ->
            "dynamic"

        Kinematic ->
            "kinematic"


strToType : String -> BodyType
strToType bodyType =
    case bodyType of
        "static" ->
            Static

        "dynamic" ->
            Dynamic

        "kinematic" ->
            Kinematic

        _ ->
            Static


strToCategoryList : String -> List Int
strToCategoryList string =
    string
        |> String.split ","
        |> List.filterMap String.toInt
        |> List.filter ((>) 16)
        |> List.unique
        |> List.sort


decoder : JD.Decoder Body
decoder =
    JD.map5 Body
        (JD.field "bodyType" bodyTypeDecoder)
        (JD.field "category" (JD.list JD.int))
        (JD.field "mask" (JD.list JD.int))
        (JD.field "x" JD.float)
        (JD.field "y" JD.float)


bodyTypeDecoder : JD.Decoder BodyType
bodyTypeDecoder =
    (JD.string |> JD.andThen (JD.succeed << strToType))
