port module Ports exposing (..)

import Json.Decode as JD


port selectProjectPathIn : (String -> msg) -> Sub msg


port selectProjectPathOut : () -> Cmd msg


port loadFileIn : (( String, String ) -> msg) -> Sub msg


port loadFileOut : String -> Cmd msg


port saveFileOut : ( String, JD.Value ) -> Cmd msg
