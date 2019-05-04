--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_Aspect = require("ecs.Aspect")
local Aspect = __TSTL_Aspect.Aspect
local __TSTL_System = require("ecs.System")
local System = __TSTL_System.System
local __TSTL_flags = require("game.flags")
local SystemFlag = __TSTL_flags.SystemFlag
local __TSTL_GameObject = require("game.components.GameObject")
local GameObject = __TSTL_GameObject.GameObject
local __TSTL_Position = require("game.components.Position")
local Position = __TSTL_Position.Position
local __TSTL_Attack = require("game.components.Attack")
local Attack = __TSTL_Attack.Attack
local __TSTL_Movement = require("game.components.Movement")
local Movement = __TSTL_Movement.Movement
local __TSTL_Abilities = require("game.components.Abilities")
local Abilities = __TSTL_Abilities.Abilities
local __TSTL_Entity = require("ecs.Entity")
local Entity = __TSTL_Entity.Entity
local __TSTL_Waypoint = require("game.components.Waypoint")
local Point = __TSTL_Waypoint.Point
local __TSTL_math = require("game.utils.math")
local sign = __TSTL_math.sign
local targetDistance
targetDistance = function(____, entity)
    local attack = entity:as(Attack)
    local pos1 = entity:as(Position)
    if attack and pos1 then
        local pos2 = attack.target:as(Position)
        if pos2 then
            return {
                x = pos2.x - pos1.x,
                y = pos2.y - pos1.y,
            }
        end
    end
    return {
        x = 0,
        y = 0,
    }
end
local track
track = function(____, distance, speed, entity)
    local gameObject = entity:as(GameObject)
    if not gameObject then
        return
    end
    local body = gameObject.fixture:getBody()
    local velocityX, velocityY = body:getLinearVelocity()
    local delta = targetDistance(nil, entity)
    local newVelocityX = sign(nil, delta.x) * (speed or 100)
    if math.abs(delta.x) < distance then
        newVelocityX = 0
    end
    body:setLinearVelocity(newVelocityX, velocityY)
end
____exports.AttackSystem = {}
local AttackSystem = ____exports.AttackSystem
AttackSystem.name = "AttackSystem"
AttackSystem.__index = AttackSystem
AttackSystem.prototype = {}
AttackSystem.prototype.__index = AttackSystem.prototype
AttackSystem.prototype.constructor = AttackSystem
AttackSystem.____super = System
setmetatable(AttackSystem, AttackSystem.____super)
setmetatable(AttackSystem.prototype, AttackSystem.____super.prototype)
function AttackSystem.new(...)
    local self = setmetatable({}, AttackSystem.prototype)
    self:____constructor(...)
    return self
end
function AttackSystem.prototype.____constructor(self, ...)
    System.prototype.____constructor(self, ...)
    self._id = ____exports.AttackSystem._id
    self._flag = ____exports.AttackSystem._flag
    self._aspect = ____exports.AttackSystem._aspect
    self.update = function(____, dt)
        self.entities:forEach(function(____, entity)
        end)
    end
    self.onRemove = function(____, entity)
        local abilities = entity:as(Abilities)
        local ____ = abilities and abilities:reset()
    end
end
AttackSystem._id = "Attack"
AttackSystem._flag = SystemFlag.Attack
AttackSystem._aspect = Aspect.new({
    Abilities,
    Attack,
    GameObject,
    Movement,
    Position,
})
return ____exports
