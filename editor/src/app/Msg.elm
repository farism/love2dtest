module Msg exposing (Msg(..))

import Draggable
import Entity exposing (Entity)
import Scene exposing (SceneMsg)


type Msg
    = DragMsg Entity (Draggable.Msg ())
    | LoadFileIn ( String, String )
    | LoadFileOut String
    | OnDragBy Draggable.Delta
    | SaveFileOut
    | SelectProjectPathIn String
    | SelectProjectPathOut
    | SelectSceneIndex Int
    | SceneMsg SceneMsg



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
