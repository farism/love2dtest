module Body exposing (Body, bodyTypes, init, decoder)

import Json.Decode as JD


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


bodyTypes : List String
bodyTypes =
    List.map typeToString [ Static, Dynamic, Kinematic ]


init : Body
init =
    { bodyType = Static
    , category = []
    , mask = []
    , x = 0
    , y = 0
    }


typeToString : BodyType -> String
typeToString bodyType =
    case bodyType of
        Static ->
            "static"

        Dynamic ->
            "dynamic"

        Kinematic ->
            "kinematic"


stringToType : String -> BodyType
stringToType bodyType =
    case bodyType of
        "static" ->
            Static

        "dynamic" ->
            Dynamic

        "kinematic" ->
            Kinematic

        _ ->
            Static


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
    (JD.string |> JD.andThen (JD.succeed << stringToType))
