module Serializers exposing (decodeLevel, encodeLevel)

import Dict exposing (Dict)
import Json.Encode as JE
import Json.Decode as JD
import Json.Decode.Pipeline as JDP exposing (hardcoded, optional, required)
import Types exposing (..)


decodeLevel : String -> Level
decodeLevel string =
    case JD.decodeString levelDecoder string of
        Err err ->
            let
                log =
                    Debug.log "decode level error" err
            in
                { id = 0
                , name = ""
                , entities = Dict.empty
                }

        Ok level ->
            level


encodeLevel : Int -> String -> Dict String Entity -> JE.Value
encodeLevel id name entities =
    levelEncoder id name entities



-- DECODERS
-- toComponent : (a -> Component) -> (JD.Decoder a -> JD.Decoder Component)
-- toComponent msg =
--     (\p -> JD.succeed (msg p))


levelDecoder : JD.Decoder Level
levelDecoder =
    JD.succeed Level
        |> required "id" JD.int
        |> required "name" JD.string
        |> required "entities" (JD.dict entityDecoder)


entityDecoder : JD.Decoder Entity
entityDecoder =
    JD.succeed Entity
        |> required "id" JD.int
        |> required "label" JD.string
        |> required "components"
            (JD.dict
                ((JD.field "id" JD.string) |> JD.andThen componentDecoder)
            )


componentDecoder : String -> JD.Decoder Component
componentDecoder id =
    (case id of
        -- "ability" ->
        --     JD.succeed AbilityParams
        --         |> toComponent Ability
        -- "aggression" ->
        --     JD.succeed AggressionParams
        --         |> required "x" JD.int
        --         |> required "y" JD.int
        --         |> required "width" JD.int
        --         |> required "height" JD.int
        --         |> required "duration" JD.int
        --         |> toComponent Aggression
        -- "animation" ->
        --     JD.succeed AnimationParams
        --         |> toComponent Animation
        -- "attack" ->
        --     JD.succeed AttackParams
        --         |> toComponent Attack
        -- "checkpoint" ->
        --     JD.succeed CheckpointParams
        --         |> required "index" JD.int
        --         |> toComponent Checkpoint
        -- "container" ->
        --     JD.succeed ContainerParams
        --         |> toComponent Container
        -- "damage" ->
        --     JD.succeed DamageParams
        --         |> required "hitpoints" JD.int
        --         |> toComponent Damage
        -- "fixture" ->
        --     JD.succeed FixtureParams
        --         |> required "x" JD.int
        --         |> required "y" JD.int
        --         |> toComponent Fixture
        -- "health" ->
        --     JD.succeed HealthParams
        --         |> required "hitpoints" JD.int
        --         |> required "armor" JD.int
        --         |> toComponent Health
        -- "input" ->
        --     JD.succeed InputParams
        --         |> toComponent Input
        -- "movement" ->
        --     JD.succeed MovementParams
        --         |> toComponent Movement
        -- "platform" ->
        --     JD.succeed PlatformParams
        --         |> required "fall" JD.int
        --         |> required "initialX" JD.int
        --         |> required "intitialY" JD.int
        --         |> toComponent Platform
        -- "player" ->
        --     JD.succeed PlayerParams
        --         |> required "alias" JD.string
        --         |> required "money" JD.int
        --         |> required "lives" JD.int
        --         |> required "documents" JD.int
        --         |> required "checkpoint" JD.int
        --         |> toComponent Player
        -- "position" ->
        --     JD.succeed PositionParams
        --         |> required "x" JD.int
        --         |> required "y" JD.int
        --         |> toComponent Position
        -- "projectile" ->
        --     JD.succeed ProjectileParams
        --         |> toComponent Projectile
        -- "snare" ->
        --     JD.succeed SnareParams
        --         |> toComponent Snare
        -- "sound" ->
        --     JD.succeed SoundParams
        --         |> toComponent Sound
        -- "sprite" ->
        --     JD.succeed SpriteParams
        --         |> required "asset" JD.string
        --         |> toComponent Sprite
        -- "trigger" ->
        --     JD.succeed TriggerParams
        --         |> toComponent Trigger
        -- "wave" ->
        --     JD.succeed WaveParams
        --         |> required "type_" JD.string
        --         |> required "x" JD.int
        --         |> required "y" JD.int
        --         |> required "amplitude" JD.float
        --         |> required "frequency" JD.float
        --         |> toComponent Wave
        -- "waypoint" ->
        --     JD.succeed WaypointParams
        --         |> required "speed" JD.int
        --         |> required "waypoints"
        --             (JD.list
        --                 (JD.succeed Vector2
        --                     |> required "x" JD.int
        --                     |> required "y" JD.int
        --                 )
        --             )
        --         |> toComponent Waypoint
        _ ->
            JD.succeed PositionParams
                |> required "x" JD.int
                |> required "y" JD.int
                |> (\params -> JD.succeed (Position params))
    )



-- ENCODERS


dictEncoder : (a -> JE.Value) -> Dict String a -> JE.Value
dictEncoder encoder dict =
    Dict.toList dict
        |> List.map (\( k, v ) -> ( k, encoder v ))
        |> JE.object


levelEncoder : Int -> String -> Dict String Entity -> JE.Value
levelEncoder id name entities =
    JE.object
        [ ( "id", JE.int id )
        , ( "name", JE.string name )
        , ( "entities", dictEncoder entityEncoder entities )
        ]


entityEncoder : Entity -> JE.Value
entityEncoder entity =
    JE.object
        [ ( "id", JE.int entity.id )
        , ( "label", JE.string entity.label )
        , ( "components", dictEncoder componentEncoder entity.components )
        ]


componentEncoder : Component -> JE.Value
componentEncoder component =
    case component of
        Ability p ->
            JE.object
                [ ( "id", JE.string "ability" )
                ]

        Aggression p ->
            JE.object
                [ ( "id", JE.string "aggression" )
                , ( "x", JE.int p.x )
                , ( "y", JE.int p.y )
                , ( "width", JE.int p.width )
                , ( "height", JE.int p.height )
                , ( "duration", JE.int p.duration )
                ]

        Animation p ->
            JE.object
                [ ( "id", JE.string "animation" )
                ]

        Attack p ->
            JE.object
                [ ( "id", JE.string "attack" )
                ]

        Checkpoint p ->
            JE.object
                [ ( "id", JE.string "checkpoint" )
                , ( "index", JE.int p.index )
                ]

        Container p ->
            JE.object
                [ ( "id", JE.string "container" )
                ]

        Damage p ->
            JE.object
                [ ( "id", JE.string "damage" )
                , ( "hitpoints", JE.int p.hitpoints )
                ]

        Fixture p ->
            JE.object
                [ ( "id", JE.string "fixture" )
                , ( "x", JE.int p.x )
                , ( "y", JE.int p.y )
                ]

        Health p ->
            JE.object
                [ ( "id", JE.string "health" )
                , ( "hitpoints", JE.int p.hitpoints )
                , ( "armor", JE.int p.armor )
                ]

        Input p ->
            JE.object
                [ ( "id", JE.string "input" )
                ]

        Movement p ->
            JE.object
                [ ( "id", JE.string "movement" )
                ]

        Platform p ->
            JE.object
                [ ( "id", JE.string "platform" )
                , ( "fall", JE.int p.fall )
                , ( "initialX", JE.int p.initialX )
                , ( "initialY", JE.int p.initialY )
                ]

        Player p ->
            JE.object
                [ ( "id", JE.string "player" )
                , ( "alias", JE.string p.alias )
                , ( "money", JE.int p.money )
                , ( "lives", JE.int p.lives )
                , ( "documents", JE.int p.documents )
                , ( "checkpoint", JE.int p.checkpoint )
                ]

        Position p ->
            JE.object
                [ ( "id", JE.string "position" )
                , ( "x", JE.int p.x )
                , ( "y", JE.int p.y )
                ]

        Projectile p ->
            JE.object
                [ ( "id", JE.string "projectile" )
                ]

        Snare p ->
            JE.object
                [ ( "id", JE.string "snare" )
                ]

        Sound p ->
            JE.object
                [ ( "id", JE.string "sound" )
                ]

        Sprite p ->
            JE.object
                [ ( "id", JE.string "sprite" )
                , ( "asset", JE.string p.asset )
                ]

        Trigger p ->
            JE.object
                [ ( "id", JE.string "trigger" )
                ]

        Wave p ->
            JE.object
                [ ( "id", JE.string "wave" )
                , ( "type_", JE.string p.type_ )
                , ( "x", JE.int p.x )
                , ( "y", JE.int p.y )
                , ( "amplitude", JE.float p.amplitude )
                , ( "frequency", JE.float p.frequency )
                ]

        Waypoint p ->
            JE.object
                [ ( "id", JE.string "waypoint" )
                , ( "speed", JE.int p.speed )
                , ( "waypoints"
                  , JE.list
                        (\{ x, y } ->
                            JE.object
                                [ ( "x", JE.int x )
                                , ( "y", JE.int y )
                                ]
                        )
                        p.waypoints
                  )
                ]
