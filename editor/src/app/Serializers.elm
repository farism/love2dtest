module Serializers exposing (decodeLevel, encodeLevel)

import Dict exposing (Dict)
import Json.Encode as JE
import Json.Decode as JD
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


levelDecoder : JD.Decoder Level
levelDecoder =
    JD.map3 Level
        (JD.field "id" JD.int)
        (JD.field "name" JD.string)
        (JD.field "entities" (JD.dict entityDecoder))


entityDecoder : JD.Decoder Entity
entityDecoder =
    JD.map3 Entity
        (JD.field "id" JD.int)
        (JD.field "label" JD.string)
        (JD.field "components"
            (JD.dict
                ((JD.field "id" JD.string) |> JD.andThen componentDecoder)
            )
        )


componentDecoder : String -> JD.Decoder Component
componentDecoder id =
    (case id of
        "ability" ->
            JD.succeed (Ability {})

        "aggression" ->
            JD.map Aggression <|
                JD.map5 AggressionParams
                    (JD.field "x" JD.int)
                    (JD.field "y" JD.int)
                    (JD.field "width" JD.int)
                    (JD.field "height" JD.int)
                    (JD.field "duration" JD.int)

        "animation" ->
            JD.succeed (Animation {})

        "attack" ->
            JD.succeed (Attack {})

        "checkpoint" ->
            JD.map Checkpoint <|
                JD.map CheckpointParams
                    (JD.field "index" JD.int)

        "container" ->
            JD.succeed (Container {})

        "damage" ->
            JD.map Damage <|
                JD.map DamageParams
                    (JD.field "hitpoints" JD.int)

        "fixture" ->
            JD.map Fixture <|
                JD.map2 FixtureParams
                    (JD.field "x" JD.int)
                    (JD.field "y" JD.int)

        "health" ->
            JD.map Health <|
                JD.map2 HealthParams
                    (JD.field "hitpoints" JD.int)
                    (JD.field "armor" JD.int)

        "input" ->
            JD.succeed (Input {})

        "movement" ->
            JD.succeed (Movement {})

        "platform" ->
            JD.map Platform <|
                JD.map3 PlatformParams
                    (JD.field "fall" JD.int)
                    (JD.field "initialX" JD.int)
                    (JD.field "intitialY" JD.int)

        "player" ->
            JD.map Player <|
                JD.map5 PlayerParams
                    (JD.field "alias" JD.string)
                    (JD.field "money" JD.int)
                    (JD.field "lives" JD.int)
                    (JD.field "documents" JD.int)
                    (JD.field "checkpoint" JD.int)

        "position" ->
            JD.map Position <|
                JD.map2 PositionParams
                    (JD.field "x" JD.int)
                    (JD.field "y" JD.int)

        "projectile" ->
            JD.succeed (Projectile {})

        "snare" ->
            JD.succeed (Snare {})

        "sound" ->
            JD.succeed (Sound {})

        "sprite" ->
            JD.map Sprite <|
                JD.map SpriteParams
                    (JD.field "asset" JD.string)

        "trigger" ->
            JD.succeed (Trigger {})

        "wave" ->
            JD.map Wave <|
                JD.map5 WaveParams
                    (JD.field "type_" JD.string)
                    (JD.field "x" JD.int)
                    (JD.field "y" JD.int)
                    (JD.field "amplitude" JD.float)
                    (JD.field "frequency" JD.float)

        "waypoint" ->
            JD.map Waypoint <|
                JD.map2 WaypointParams
                    (JD.field "speed" JD.int)
                    (JD.field "waypoints"
                        (JD.list
                            (JD.map2 Vector2
                                (JD.field "x" JD.int)
                                (JD.field "y" JD.int)
                            )
                        )
                    )

        _ ->
            JD.map Position <|
                JD.map2 PositionParams
                    (JD.field "x" JD.int)
                    (JD.field "y" JD.int)
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
