--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_Aspect = require("ecs.Aspect")
local Aspect = __TSTL_Aspect.Aspect
local __TSTL_Entity = require("ecs.Entity")
local Entity = __TSTL_Entity.Entity
local __TSTL_System = require("ecs.System")
local System = __TSTL_System.System
local __TSTL_Dash = require("game.components.Dash")
local Dash = __TSTL_Dash.Dash
local __TSTL_GameObject = require("game.components.GameObject")
local GameObject = __TSTL_GameObject.GameObject
local __TSTL_Movement = require("game.components.Movement")
local Direction = __TSTL_Movement.Direction
local Movement = __TSTL_Movement.Movement
local __TSTL_flags = require("game.flags")
local SystemFlag = __TSTL_flags.SystemFlag
____exports.DashSystem = {}
local DashSystem = ____exports.DashSystem
DashSystem.name = "DashSystem"
DashSystem.__index = DashSystem
DashSystem.prototype = {}
DashSystem.prototype.__index = DashSystem.prototype
DashSystem.prototype.constructor = DashSystem
DashSystem.____super = System
setmetatable(DashSystem, DashSystem.____super)
setmetatable(DashSystem.prototype, DashSystem.____super.prototype)
function DashSystem.new(...)
    local self = setmetatable({}, DashSystem.prototype)
    self:____constructor(...)
    return self
end
function DashSystem.prototype.____constructor(self, ...)
    System.prototype.____constructor(self, ...)
    self._id = ____exports.DashSystem._id
    self._flag = ____exports.DashSystem._flag
    self._aspect = ____exports.DashSystem._aspect
    self.update = function(____, dt)
        self.entities:forEach(function(____, entity)
            local dash = entity:as(Dash)
            local gameObject = entity:as(GameObject)
            local movement = entity:as(Movement)
            if not dash or not gameObject or not movement then
                return
            end
            local body = gameObject.fixture:getBody()
            if movement.direction == Direction.Left then
                body:setLinearVelocity(-2000, 0)
            elseif movement.direction == Direction.Right then
                body:setLinearVelocity(2000, 0)
            end
        end)
    end
    self.onAdd = function(____, entity)
        local gameObject = entity:as(GameObject)
        local ____ = gameObject and gameObject.fixture:getBody():setGravityScale(0)
    end
    self.onRemove = function(____, entity)
        local gameObject = entity:as(GameObject)
        local ____ = gameObject and gameObject.fixture:getBody():setGravityScale(1)
    end
end
DashSystem._id = "Dash"
DashSystem._flag = SystemFlag.Dash
DashSystem._aspect = Aspect.new({
    Dash,
    GameObject,
    Movement,
})
return ____exports
