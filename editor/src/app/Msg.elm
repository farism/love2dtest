module Msg exposing (..)

import Draggable
import Entity exposing (..)
import Component exposing (..)


type Msg
    = LoadFileIn ( String, String )
    | LoadFileOut String
    | QueueComponent Component
    | RemoveComponent String
    | SaveFileOut
    | SelectComponent String
    | SelectEntity Int
    | SelectProjectPathIn String
    | SelectProjectPathOut
    | SelectSceneIndex Int



-- type Msg
--     = AddComponent Component
--     | AddEntity
--     | DragMsg Entity (Draggable.Msg ())
--     | LoadFileIn ( String, String )
--     | LoadFileOut String
--     | OnDragBy Draggable.Delta
--     | QueueComponent Component
--     | Redo
--     | RemoveComponent String
--     | RemoveEntity
--     | SaveFileOut
--     | SelectComponent Component
--     | SelectEntity Entity
--     | SelectProjectPathIn String
--     | SelectProjectPathOut
--     | SelectTab Int
--     | SetSceneHeight Int
--     | SetSceneId String
--     | SetSceneName String
--     | SetSceneWidth Int
--     | Undo
--     | UpdateBody Body
--     | UpdateParam String Param String
