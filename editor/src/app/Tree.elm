module Tree exposing (TreeNode(..), hasJson, decode)

import Json.Decode as JD
import Json.Decode.Pipeline as JDE


type alias DirectoryFields =
    { path : String
    , name : String
    , children : List TreeNode
    }


type alias FileFields =
    { path : String
    , name : String
    , extension : String
    }


type TreeNode
    = Directory DirectoryFields
    | File FileFields


decode : String -> Result JD.Error TreeNode
decode string =
    case JD.decodeString (treeDecoder "directory") string of
        Err err ->
            Err (Debug.log "decode tree error" err)

        Ok tree ->
            Ok tree


hasJson : TreeNode -> Bool
hasJson node =
    case node of
        Directory directory ->
            List.any hasJson directory.children

        File file ->
            file.extension == ".json"


treeDecoder : String -> JD.Decoder TreeNode
treeDecoder type_ =
    case type_ of
        "directory" ->
            directoryDecoder

        "file" ->
            fileDecoder

        _ ->
            directoryDecoder


directoryDecoder : JD.Decoder TreeNode
directoryDecoder =
    JD.map Directory
        (JD.map3 DirectoryFields
            (JD.field "path" JD.string)
            (JD.field "name" JD.string)
            (JD.field "children"
                (JD.list (JD.field "type" JD.string |> JD.andThen treeDecoder))
            )
        )


fileDecoder : JD.Decoder TreeNode
fileDecoder =
    JD.map File
        (JD.map3 FileFields
            (JD.field "path" JD.string)
            (JD.field "name" JD.string)
            (JD.field "extension" JD.string)
        )
