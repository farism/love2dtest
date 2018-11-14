port module App exposing (..)

import Maybe
import Browser
import Json.Decode as JD
import Dict exposing (Dict)
import Html.Styled.Events exposing (onClick)
import Html.Styled.Attributes exposing (disabled, value)
import Html.Styled exposing (..)
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


type Component
    = Position
        { x : Float
        , y : Float
        }
    | Sprite
        { x : Float
        , y : Float
        }


getComponentsList : List Component
getComponentsList =
    [ Position { x = 0, y = 0 }
    , Sprite { x = 0, y = 0 }
    ]


getComponentId : Component -> String
getComponentId component =
    case component of
        Position _ ->
            "position"

        Sprite _ ->
            "sprite"


type alias Entity =
    { id : Int
    , label : String
    , components : Dict String Component
    }


type alias Model =
    { nextId : Int
    , entities : Dict Int Entity
    , selectedEntity : Maybe Entity
    , selectedComponent : Maybe Component
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


createPosition : Int -> Float -> Float -> Component
createPosition id x y =
    Position
        { x = x
        , y = y
        }


createSprite : Int -> Float -> Float -> Component
createSprite id x y =
    Sprite
        { x = x
        , y = y
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
                    , selectedComponent = Just component
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
                foo =
                    Debug.log "selected component" component
            in
                ( { model | queuedComponent = Nothing, selectedComponent = Just component }, Cmd.none )

        QueueComponent component ->
            let
                foo =
                    Debug.log "queued component" component
            in
                ( { model | queuedComponent = Just component, selectedComponent = Nothing }, Cmd.none )


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
                    [ div [] [ text <| "id: " ++ (String.fromInt entity.id) ]
                    , div [] [ text <| "label: " ++ entity.label ]
                    ]
        ]


entityManagerView : Model -> Html Msg
entityManagerView model =
    div [ entityManagerStyles ]
        [ div []
            [ button [ onClick AddEntity ] [ text "add entity" ]
            ]
        , div [ entityListStyles ]
            [ ul []
                (List.map
                    (\entity ->
                        li
                            [ entityListItemStyles, onClick (SelectEntity entity) ]
                            [ text <| String.fromInt entity.id ]
                    )
                    (Dict.values model.entities)
                )
            ]
        , div [ selectedEntityStyles ]
            [ selectedEntityView model
            ]
        ]


componentsListView : (Component -> Msg) -> List Component -> Html Msg
componentsListView msg components =
    div []
        [ ul []
            (List.map
                (\component ->
                    li
                        [ componentListItemStyles, onClick (msg component) ]
                        [ text <| getComponentId component ]
                )
                components
            )
        ]


availableComponentsView : Model -> Html Msg
availableComponentsView model =
    let
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
            [ componentsListView QueueComponent available
            ]


positionParams : { x : Float, y : Float } -> Html Msg
positionParams { x, y } =
    div []
        [ input [ value <| String.fromFloat x ] []
        , input [ value <| String.fromFloat y ] []
        ]


spriteParams : { x : Float, y : Float } -> Html Msg
spriteParams { x, y } =
    div []
        [ input [ value <| String.fromFloat x ] []
        , input [ value <| String.fromFloat y ] []
        ]


selectedComponentsView : Entity -> Html Msg
selectedComponentsView entity =
    componentsListView SelectComponent (Dict.values entity.components)


selectedComponentView : Model -> Html Msg
selectedComponentView model =
    div []
        [ case model.selectedComponent of
            Nothing ->
                text "Select a component"

            Just component ->
                case component of
                    Position params ->
                        positionParams params

                    Sprite params ->
                        spriteParams params
        ]


addComponentButton : Model -> Html Msg
addComponentButton model =
    let
        label =
            "add component"

        disabledBtn =
            button [ disabled True ] [ text label ]
    in
        case model.queuedComponent of
            Nothing ->
                disabledBtn

            Just component ->
                button [ onClick (AddComponent component) ] [ text label ]


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
                            [ selectedComponentsView entity ]
                        , div [ selectedComponentStyles ]
                            [ selectedComponentView model ]
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
