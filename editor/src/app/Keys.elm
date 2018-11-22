module Keys exposing (..)

import Browser.Events exposing (onKeyDown, onKeyUp)
import Json.Decode as JD
import Types exposing (..)


downs : (RawKey -> msg) -> Sub msg
downs toMsg =
    onKeyDown (eventKeyDecoder |> JD.map toMsg)


ups : (RawKey -> msg) -> Sub msg
ups toMsg =
    onKeyUp (eventKeyDecoder |> JD.map toMsg)


eventKeyDecoder : JD.Decoder RawKey
eventKeyDecoder =
    JD.map3 (\key repeat metaKey -> RawKey key repeat metaKey)
        (JD.field "key" JD.string)
        (JD.field "repeat" JD.bool)
        (JD.field "metaKey" JD.bool)
