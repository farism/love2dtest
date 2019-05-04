--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_conf = require("conf")
local WINDOW_WIDTH = __TSTL_conf.WINDOW_WIDTH
local WINDOW_HEIGHT = __TSTL_conf.WINDOW_HEIGHT
local __TSTL_Entity = require("ecs.Entity")
local Entity = __TSTL_Entity.Entity
local __TSTL_Component = require("ecs.Component")
local Component = __TSTL_Component.Component
local __TSTL_Manager = require("ecs.Manager")
local Manager = __TSTL_Manager.Manager
local __TSTL_GameObject = require("game.components.GameObject")
local GameObject = __TSTL_GameObject.GameObject
local __TSTL_Player = require("game.components.Player")
local Player = __TSTL_Player.Player
local __TSTL_Position = require("game.components.Position")
local Position = __TSTL_Position.Position
local __TSTL_Input = require("game.components.Input")
local Input = __TSTL_Input.Input
local __TSTL_Health = require("game.components.Health")
local Health = __TSTL_Health.Health
local __TSTL_Abilities = require("game.components.Abilities")
local Abilities = __TSTL_Abilities.Abilities
local __TSTL_Animation = require("game.components.Animation")
local Animation = __TSTL_Animation.Animation
local __TSTL_Movement = require("game.components.Movement")
local Movement = __TSTL_Movement.Movement
local __TSTL_Projectile = require("game.components.Projectile")
local Projectile = __TSTL_Projectile.Projectile
local __TSTL_Damage = require("game.components.Damage")
local Damage = __TSTL_Damage.Damage
____exports.CollisionCategory = {}
____exports.CollisionCategory.Static = 1
____exports.CollisionCategory[1] = "Static"
____exports.CollisionCategory.Player = 2
____exports.CollisionCategory[2] = "Player"
____exports.CollisionCategory.PlayerAttack = 3
____exports.CollisionCategory[3] = "PlayerAttack"
____exports.CollisionCategory.Enemy = 4
____exports.CollisionCategory[4] = "Enemy"
____exports.CollisionCategory.EnemyAttack = 5
____exports.CollisionCategory[5] = "EnemyAttack"
____exports.CollisionCategory.Container = 6
____exports.CollisionCategory[6] = "Container"
____exports.CollisionCategory.Bomb = 7
____exports.CollisionCategory[7] = "Bomb"
____exports.CollisionCategory.Aggression = 8
____exports.CollisionCategory[8] = "Aggression"
____exports.Blueprint = {}
____exports.Blueprint.Ground = "ground"
____exports.Blueprint.ground = "Ground"
____exports.Blueprint.Mob = "mob"
____exports.Blueprint.mob = "Mob"
____exports.Blueprint.Player = "player"
____exports.Blueprint.player = "Player"
____exports.Blueprint.Slope = "slope"
____exports.Blueprint.slope = "Slope"
____exports.Blueprint.ThrowingPick = "throwingPick"
____exports.Blueprint.throwingPick = "ThrowingPick"
____exports.Blueprint.Icicle = "icicle"
____exports.Blueprint.icicle = "Icicle"
____exports.createPlayer = function(____, manager, initX, initY)
    if initX == nil then
        initX = 0
    end
    if initY == nil then
        initY = 0
    end
    local body = love.physics.newBody(manager.world, initX, initY, "dynamic")
    local shape = love.physics.newCircleShape(16)
    local fixture = love.physics.newFixture(body, shape, 1)
    body:setFixedRotation(true)
    fixture:setFriction(1)
    fixture:setCategory(____exports.CollisionCategory.Player)
    fixture:setMask(____exports.CollisionCategory.Enemy)
    local entity = manager:createEntity()
    entity.userData = {blueprint = ____exports.Blueprint.Player}
    entity:addAll({
        Abilities.new(),
        GameObject.new(entity, fixture),
        Health.new(),
        Input.new(),
        Movement.new(),
        Player.new(),
        Position.new(),
    })
end
____exports.createIcicle = function(____, initX, initY)
    if initX == nil then
        initX = 0
    end
    if initY == nil then
        initY = 0
    end
    return function(____, manager)
        local body = love.physics.newBody(manager.world, initX, initY, "static")
        local shape = love.physics.newRectangleShape(64, 64)
        local fixture = love.physics.newFixture(body, shape, 1)
        body:setFixedRotation(true)
        fixture:setCategory(____exports.CollisionCategory.Static)
        local entity = manager:createEntity()
        entity.userData.blueprint = ____exports.Blueprint.Icicle
        entity:addAll({
            Damage.new(1),
            GameObject.new(entity, fixture),
        })
        return entity
    end
end
____exports.createThrowingPick = function(____, user, initX, initY)
    if initX == nil then
        initX = 0
    end
    if initY == nil then
        initY = 0
    end
    local manager = user.manager
    local body = love.physics.newBody(manager.world, initX, initY, "dynamic")
    local shape = love.physics.newRectangleShape(8, 8)
    local fixture = love.physics.newFixture(body, shape, 1)
    body:setFixedRotation(true)
    fixture:setFriction(1)
    fixture:setCategory(____exports.CollisionCategory.Player)
    fixture:setMask(____exports.CollisionCategory.Enemy)
    local entity = manager:createEntity()
    entity.userData = {blueprint = ____exports.Blueprint.ThrowingPick}
    entity:addAll({
        Damage.new(1),
        GameObject.new(entity, fixture),
        Position.new(),
        Projectile.new(),
    })
    return entity
end
____exports.createMob = function(____, manager, initX, initY)
    if initX == nil then
        initX = 0
    end
    if initY == nil then
        initY = 0
    end
    local body = love.physics.newBody(manager.world, initX, initY, "dynamic")
    local shape = love.physics.newRectangleShape(32, 32)
    local fixture = love.physics.newFixture(body, shape, 1)
    body:setFixedRotation(true)
    fixture:setCategory(____exports.CollisionCategory.Enemy)
    local entity = manager:createEntity()
    entity.userData.blueprint = ____exports.Blueprint.Mob
    entity:addAll({
        GameObject.new(entity, fixture),
        Health.new(1, 0),
        Movement.new(),
        Position.new(),
    })
    return entity
end
____exports.createSlashMob = function(____, manager, initX, initY)
    if initX == nil then
        initX = 0
    end
    if initY == nil then
        initY = 0
    end
    local body = love.physics.newBody(manager.world, initX, initY, "dynamic")
    local shape = love.physics.newRectangleShape(32, 32)
    local fixture = love.physics.newFixture(body, shape, 1)
    body:setFixedRotation(true)
    fixture:setCategory(____exports.CollisionCategory.Enemy)
    local entity = manager:createEntity()
    entity.userData.blueprint = ____exports.Blueprint.Mob
    entity:addAll({
        GameObject.new(entity, fixture),
        Health.new(1, 0),
        Movement.new(),
        Position.new(),
    })
    return entity
end
____exports.createSlope = function(____, manager)
    local body = love.physics.newBody(manager.world, 1000, 0, "static")
    local shape = love.physics.newPolygonShape(500, WINDOW_HEIGHT - 30, 1500, WINDOW_HEIGHT - 130, 1500, WINDOW_HEIGHT - 30)
    local fixture = love.physics.newFixture(body, shape, 1)
    local entity = manager:createEntity()
    entity.userData = {blueprint = ____exports.Blueprint.Slope}
    entity:addAll({GameObject.new(entity, fixture)})
    return entity
end
____exports.createGround = function(____, manager)
    local body = love.physics.newBody(manager.world, WINDOW_WIDTH / 2, WINDOW_HEIGHT - 15, "static")
    local shape = love.physics.newRectangleShape(WINDOW_WIDTH * 10, 30)
    local fixture = love.physics.newFixture(body, shape, 1)
    local entity = manager:createEntity()
    entity.userData = {blueprint = ____exports.Blueprint.Ground}
    entity:addAll({GameObject.new(entity, fixture)})
    return entity
end
return ____exports
