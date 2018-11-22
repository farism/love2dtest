module Model exposing (Model, init)

import Component exposing (Component)
import Scene exposing (Scene)
import Tree exposing (TreeNode)


type alias Model =
    { sceneParseError : Maybe String
    , scenes : List Scene
    , selectedSceneIndex : Maybe Int
    , tree : Maybe TreeNode
    }


init : Model
init =
    { sceneParseError = Nothing
    , scenes = []
    , selectedSceneIndex = Nothing
    , tree = Nothing
    }
