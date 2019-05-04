--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_System = require("ecs.System")
local System = __TSTL_System.System
local __TSTL_flags = require("game.flags")
local SystemFlag = __TSTL_flags.SystemFlag
local __TSTL_Aspect = require("ecs.Aspect")
local Aspect = __TSTL_Aspect.Aspect
local __TSTL_Health = require("game.components.Health")
local Health = __TSTL_Health.Health
local __TSTL_Respawn = require("game.components.Respawn")
local Respawn = __TSTL_Respawn.Respawn
local __TSTL_Player = require("game.components.Player")
local Player = __TSTL_Player.Player
local __TSTL_factory = require("game.utils.factory")
local Blueprint = __TSTL_factory.Blueprint
local __TSTL_Entity = require("ecs.Entity")
local Entity = __TSTL_Entity.Entity
local deathFunctions = {[Blueprint.Player] = function(____, entity)
    local health = entity:as(Health)
    local player = entity:as(Player)
    if not player or not health then
        return
    end
    health.hitpoints = 1
    player.lives = player.lives - 1
    entity:add(Respawn.new(3))
end}
____exports.DeathSystem = {}
local DeathSystem = ____exports.DeathSystem
DeathSystem.name = "DeathSystem"
DeathSystem.__index = DeathSystem
DeathSystem.prototype = {}
DeathSystem.prototype.__index = DeathSystem.prototype
DeathSystem.prototype.constructor = DeathSystem
DeathSystem.____super = System
setmetatable(DeathSystem, DeathSystem.____super)
setmetatable(DeathSystem.prototype, DeathSystem.____super.prototype)
function DeathSystem.new(...)
    local self = setmetatable({}, DeathSystem.prototype)
    self:____constructor(...)
    return self
end
function DeathSystem.prototype.____constructor(self, ...)
    System.prototype.____constructor(self, ...)
    self._id = ____exports.DeathSystem._id
    self._flag = ____exports.DeathSystem._flag
    self._aspect = ____exports.DeathSystem._aspect
    self.update = function(____, dt)
        self.entities:forEach(function(____, entity)
            local health = entity:as(Health)
            if not health then
                return
            end
            if health.hitpoints <= 0 and entity.userData.blueprint then
                local fn
                fn = deathFunctions[entity.userData.blueprint]
                local ____ = fn and fn(nil, entity)
            end
        end)
    end
end
DeathSystem._id = "DeathSystem"
DeathSystem._flag = SystemFlag.Death
DeathSystem._aspect = Aspect.new({Health})
return ____exports
