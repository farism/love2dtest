port module App exposing (..)

import Maybe
import Browser
import Json.Decode as JD
import Dict exposing (Dict)
import Html.Styled.Events exposing (onClick, onInput)
import Html.Styled.Attributes exposing (disabled, placeholder, value)
import Html.Styled exposing (Html, button, div, input, li, text, ul, toUnstyled)
import Styles exposing (..)


port openFileIn : (String -> msg) -> Sub msg


port openFileOut : () -> Cmd msg


type alias Flags =
    { foo : String
    }


type Msg
    = NoOp
    | OpenLevel
    | SaveLevel
    | AddEntity
    | RemoveEntity
    | AddComponent Component
    | OpenFileIn String
    | SelectEntity Entity
    | SelectComponent Component
    | QueueComponent Component
    | UpdateComponent Component


type WaveType
    = Circular
    | Horizontal
    | Vertical


waveTypeToString : WaveType -> String
waveTypeToString type_ =
    case type_ of
        Circular ->
            "circular"

        Horizontal ->
            "horizontal"

        Vertical ->
            "vertical"


type Component
    = Ability {}
    | Aggression { x : Int, y : Int }
    | Animation {}
    | Attack {}
    | Container {}
    | Damage { hitpoints : Int }
    | Fixture { x : Int, y : Int }
    | Health { hitpoints : Int, armor : Int }
    | Input {}
    | Movement {}
    | Platform { fall : Int, initialX : Int, initialY : Int }
    | Player { alias : String, money : Int, lives : Int, documents : Int, checkpoint : Int }
    | Position { x : Int, y : Int }
    | Projectile {}
    | Snare {}
    | Sound {}
    | Sprite { asset : String }
    | Trigger {}
    | Wave { type_ : WaveType, x : Int, y : Int, amplitude : Float, frequency : Float }
    | Waypoint { speed : Int, waypoints : List { x : Int, y : Int } }


getComponentsList : List Component
getComponentsList =
    [ Ability {}
    , Aggression { x = 0, y = 0 }
    , Animation {}
    , Attack {}
    , Container {}
    , Damage { hitpoints = 0 }
    , Fixture { x = 0, y = 0 }
    , Health { hitpoints = 0, armor = 0 }
    , Input {}
    , Movement {}
    , Platform { fall = 1, initialX = 0, initialY = 0 }
    , Player { alias = "", money = 0, lives = 100, documents = 0, checkpoint = 1 }
    , Position { x = 0, y = 0 }
    , Projectile {}
    , Snare {}
    , Sound {}
    , Sprite { asset = "" }
    , Trigger {}
    , Wave { type_ = Circular, x = 0, y = 0, amplitude = 1, frequency = 1 }
    , Waypoint { speed = 1, waypoints = [] }
    ]


getComponentId : Component -> String
getComponentId component =
    case component of
        Ability _ ->
            "ability"

        Aggression _ ->
            "aggression"

        Animation _ ->
            "animation"

        Attack _ ->
            "attack"

        Container _ ->
            "container"

        Damage _ ->
            "damage"

        Fixture _ ->
            "fixture"

        Health _ ->
            "health"

        Input _ ->
            "input"

        Movement _ ->
            "movement"

        Platform _ ->
            "platform"

        Player _ ->
            "player"

        Position _ ->
            "position"

        Projectile _ ->
            "projectile"

        Snare _ ->
            "snare"

        Sound _ ->
            "sound"

        Sprite _ ->
            "sprite"

        Trigger _ ->
            "trigger"

        Wave _ ->
            "wave"

        Waypoint _ ->
            "waypoint"


type alias Entity =
    { id : Int
    , label : String
    , components : Dict String Component
    }


type alias Model =
    { nextId : Int
    , entities : Dict Int Entity
    , selectedEntity : Maybe Entity
    , selectedComponent : Maybe String
    , queuedComponent : Maybe Component
    }


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view >> toUnstyled
        , update = update
        , subscriptions = subscriptions
        }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( initialModel
    , Cmd.none
    )


initialModel : Model
initialModel =
    { nextId = 0
    , entities = Dict.empty
    , selectedEntity = Nothing
    , selectedComponent = Nothing
    , queuedComponent = Nothing
    }


createEntity : Int -> String -> Entity
createEntity id label =
    { id = id
    , label = label
    , components = Dict.empty
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        OpenLevel ->
            ( model, openFileOut () )

        SaveLevel ->
            ( model, Cmd.none )

        AddEntity ->
            let
                nextId =
                    model.nextId + 1

                entity =
                    createEntity nextId ""

                entities =
                    Dict.insert entity.id entity model.entities
            in
                ( { model | nextId = nextId, entities = entities, selectedEntity = Just entity }, Cmd.none )

        RemoveEntity ->
            let
                ( selectedEntity, entities ) =
                    case model.selectedEntity of
                        Nothing ->
                            ( model.selectedEntity, model.entities )

                        Just entity ->
                            ( Nothing, Dict.remove entity.id model.entities )
            in
                ( { model | selectedEntity = selectedEntity, entities = entities }, Cmd.none )

        AddComponent component ->
            let
                ( selectedEntity, entities ) =
                    case model.selectedEntity of
                        Nothing ->
                            ( Nothing, model.entities )

                        Just entity ->
                            let
                                id =
                                    getComponentId component

                                components =
                                    Dict.insert id component entity.components

                                newEntity =
                                    { entity | components = components }
                            in
                                ( Just newEntity, Dict.insert newEntity.id newEntity model.entities )
            in
                ( { model
                    | queuedComponent = Nothing
                    , selectedComponent = Just <| getComponentId component
                    , selectedEntity = selectedEntity
                    , entities = entities
                  }
                , Cmd.none
                )

        OpenFileIn value ->
            let
                foo =
                    Debug.log "opened" value
            in
                ( model, Cmd.none )

        SelectEntity entity ->
            let
                foo =
                    Debug.log "selected entity" entity
            in
                ( { model | selectedEntity = Just entity, selectedComponent = Nothing }, Cmd.none )

        SelectComponent component ->
            let
                componentId =
                    getComponentId component

                foo =
                    Debug.log "selected component" component
            in
                ( { model | queuedComponent = Nothing, selectedComponent = Just componentId }, Cmd.none )

        QueueComponent component ->
            let
                foo =
                    Debug.log "queued component" component
            in
                ( { model | queuedComponent = Just component, selectedComponent = Nothing }, Cmd.none )

        UpdateComponent component ->
            let
                ( selectedEntity, newEntities ) =
                    case model.selectedEntity of
                        Nothing ->
                            ( model.selectedEntity, model.entities )

                        Just entity ->
                            let
                                componentId =
                                    getComponentId component

                                components =
                                    Dict.insert componentId component entity.components

                                newEntity =
                                    { entity | components = components }
                            in
                                ( Just newEntity, Dict.insert newEntity.id newEntity model.entities )
            in
                ( { model | entities = newEntities, selectedEntity = selectedEntity }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ openFileIn OpenFileIn
        ]


selectedEntityView : Model -> Html Msg
selectedEntityView model =
    div []
        [ case model.selectedEntity of
            Nothing ->
                text "Select an entity"

            Just entity ->
                div []
                    [ div []
                        [ text <| "id: " ++ (String.fromInt entity.id)
                        ]
                    , div []
                        [ input [ value entity.label, placeholder "label" ] []
                        ]
                    ]
        ]


entityListView : Model -> Html Msg
entityListView model =
    let
        selectedId =
            case model.selectedEntity of
                Nothing ->
                    -1

                Just entity ->
                    entity.id
    in
        ul []
            (List.map
                (\entity ->
                    let
                        style =
                            if selectedId == entity.id then
                                entityListItemSelectedStyles
                            else
                                entityListItemStyles
                    in
                        li
                            [ style, onClick (SelectEntity entity) ]
                            [ text <| String.fromInt entity.id ]
                )
                (Dict.values model.entities)
            )


entityManagerView : Model -> Html Msg
entityManagerView model =
    div [ entityManagerStyles ]
        [ div []
            [ button [ onClick AddEntity ] [ text "add entity" ]
            ]
        , div [ entityListStyles ]
            [ entityListView model
            ]
        , div [ selectedEntityStyles ]
            [ selectedEntityView model
            ]
        ]


componentsListView : (Component -> Msg) -> List Component -> Maybe String -> Html Msg
componentsListView msg components selected =
    let
        selectedId =
            case selected of
                Nothing ->
                    ""

                Just componentId ->
                    componentId
    in
        div []
            [ ul []
                (List.map
                    (\component ->
                        let
                            style =
                                if selectedId == (getComponentId component) then
                                    componentListItemSelectedStyles
                                else
                                    componentListItemStyles
                        in
                            li
                                [ style, onClick (msg component) ]
                                [ text <| getComponentId component ]
                    )
                    components
                )
            ]


availableComponentsView : Model -> Html Msg
availableComponentsView model =
    let
        queuedComponentId =
            case model.queuedComponent of
                Nothing ->
                    ""

                Just component ->
                    getComponentId component

        available =
            case model.selectedEntity of
                Nothing ->
                    getComponentsList

                Just entity ->
                    let
                        used =
                            Dict.keys entity.components
                    in
                        List.filter
                            (\component -> List.member (getComponentId component) used == False)
                            getComponentsList
    in
        div []
            [ componentsListView QueueComponent available (Just queuedComponentId)
            ]


toInt : Int -> String -> Int
toInt default value =
    if value == "" then
        0
    else
        case String.toInt value of
            Nothing ->
                default

            Just int ->
                int


toFloat : Float -> String -> Float
toFloat default value =
    if value == "" then
        0
    else
        case String.toFloat value of
            Nothing ->
                default

            Just int ->
                int


paramInput : String -> (String -> a) -> (a -> Component) -> Html Msg
paramInput param converter updater =
    input
        [ onInput
            (\value ->
                UpdateComponent (updater <| converter value)
            )
        , value param
        ]
        []


paramInputString : String -> (String -> Component) -> Html Msg
paramInputString param updater =
    paramInput param (\val -> val) updater


paramInputInt : Int -> (Int -> Component) -> Html Msg
paramInputInt param updater =
    paramInput (String.fromInt param) (toInt param) updater


paramInputFloat : Float -> (Float -> Component) -> Html Msg
paramInputFloat param updater =
    paramInput (String.fromFloat param) (toFloat param) updater


positionParams : { x : Int, y : Int } -> Html Msg
positionParams position =
    div []
        [ paramInputInt position.x (\x -> Position { position | x = x })
        , paramInputInt position.y (\y -> Position { position | y = y })
        ]


fixtureParams : { x : Int, y : Int } -> Html Msg
fixtureParams fixture =
    div []
        [ paramInputInt fixture.x (\x -> Fixture { fixture | x = x })
        , paramInputInt fixture.y (\y -> Fixture { fixture | y = y })
        ]


spriteParams : { asset : String } -> Html Msg
spriteParams sprite =
    div []
        [ paramInputString sprite.asset (\asset -> Sprite { sprite | asset = asset })
        ]


selectedComponentsView : Entity -> Model -> Html Msg
selectedComponentsView entity model =
    componentsListView SelectComponent (Dict.values entity.components) model.selectedComponent


selectedComponentView : Entity -> Model -> Html Msg
selectedComponentView entity model =
    div []
        [ case model.selectedComponent of
            Nothing ->
                text "Select a component"

            Just componentId ->
                case Dict.get componentId entity.components of
                    Nothing ->
                        text "Undefined component"

                    Just component ->
                        case component of
                            Position params ->
                                positionParams params

                            Fixture params ->
                                fixtureParams params

                            Sprite params ->
                                spriteParams params

                            _ ->
                                div [] []
        ]


addComponentButton : Model -> Html Msg
addComponentButton model =
    let
        disabledBtn =
            button [ disabled True ] [ text "add component" ]
    in
        case model.queuedComponent of
            Nothing ->
                disabledBtn

            Just component ->
                button [ onClick (AddComponent component) ] [ text "add component" ]


componentManagerView : Model -> Html Msg
componentManagerView model =
    let
        children =
            case model.selectedEntity of
                Nothing ->
                    [ text "Select an entity" ]

                Just entity ->
                    [ div [ availableComponentsStyles ]
                        [ div []
                            [ addComponentButton model ]
                        , div [ availableComponentsListStyles ]
                            [ availableComponentsView model ]
                        ]
                    , div [ selectedComponentsStyles ]
                        [ div [ selectedComponentsListStyles ]
                            [ selectedComponentsView entity model ]
                        , div [ selectedComponentStyles ]
                            [ selectedComponentView entity model ]
                        ]
                    ]
    in
        div [ componentManagerStyles ] children


toolbarView : Model -> Html Msg
toolbarView model =
    div [ toolbarStyles ]
        [ button [ onClick OpenLevel ] [ text "open level" ]
        , button [ onClick SaveLevel ] [ text "save level" ]
        ]


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ toolbarView model
            , entityManagerView model
            , componentManagerView model
            ]
        ]
