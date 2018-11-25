module Entity exposing (Entity, decoder, init, encoder)

import Dict exposing (Dict)
import Draggable
import Json.Decode.Pipeline as JDE
import Json.Decode as JD
import Json.Encode as JE
import Component exposing (Component)
import Vertex exposing (Vertex)
import Helpers exposing (dictEncoder, strToInt)


type alias Entity =
    { id : Int
    , label : String
    , components : Dict String Component
    , dragVertex : Vertex
    , drag : Draggable.State ()
    }


init : Int -> Entity
init id =
    { id = id
    , label = ""
    , components = Dict.empty
    , dragVertex = Vertex 0 0
    , drag = Draggable.init
    }


decoder : JD.Decoder Entity
decoder =
    JD.succeed Entity
        |> JDE.required "id" JD.int
        |> JDE.required "label" JD.string
        |> JDE.required "components" (JD.dict Component.decoder)
        |> JDE.required "dragVertex" Vertex.decoder
        |> JDE.hardcoded Draggable.init


encoder : Entity -> JE.Value
encoder { id, label, components, dragVertex } =
    JE.object
        [ ( "id", JE.int id )
        , ( "label", JE.string label )
        , ( "components", dictEncoder Component.encoder components )
        , ( "dragVertex", Vertex.encoder dragVertex )
        ]
