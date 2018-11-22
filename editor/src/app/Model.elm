module Model exposing (Model)

import Component exposing (Component)
import Scene exposing (Scene)
import Tree exposing (TreeNode)


type alias Model =
    { sceneParseError : Maybe String
    , scenes : List Scene
    , queuedComponent : Maybe Component
    , selectedComponent : Maybe String
    , selectedEntity : Maybe Int
    , selectedSceneIndex : Maybe Int
    , tree : Maybe TreeNode
    }
