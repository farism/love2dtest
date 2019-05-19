module Entity exposing (Entity, decoder, init, encoder)

import Component exposing (Component)
import Dict exposing (Dict)
import Draggable
import Helpers exposing (dictEncoder, strToInt)
import Json.Decode as JD
import Json.Decode.Pipeline as JDE
import Json.Encode as JE
import Vertex exposing (Vertex)


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
