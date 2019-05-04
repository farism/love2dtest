--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_System = require("ecs.System")
local System = __TSTL_System.System
local __TSTL_flags = require("game.flags")
local SystemFlag = __TSTL_flags.SystemFlag
local __TSTL_Aspect = require("ecs.Aspect")
local NeverAspect = __TSTL_Aspect.NeverAspect
local __TSTL_collision = require("game.utils.collision")
local check = __TSTL_collision.check
local hasComponent = __TSTL_collision.hasComponent
local isNotBodyType = __TSTL_collision.isNotBodyType
local __TSTL_Damage = require("game.components.Damage")
local Damage = __TSTL_Damage.Damage
local __TSTL_Health = require("game.components.Health")
local Health = __TSTL_Health.Health
____exports.DamageSystem = {}
local DamageSystem = ____exports.DamageSystem
DamageSystem.name = "DamageSystem"
DamageSystem.__index = DamageSystem
DamageSystem.prototype = {}
DamageSystem.prototype.__index = DamageSystem.prototype
DamageSystem.prototype.constructor = DamageSystem
DamageSystem.____super = System
setmetatable(DamageSystem, DamageSystem.____super)
setmetatable(DamageSystem.prototype, DamageSystem.____super.prototype)
function DamageSystem.new(...)
    local self = setmetatable({}, DamageSystem.prototype)
    self:____constructor(...)
    return self
end
function DamageSystem.prototype.____constructor(self, ...)
    System.prototype.____constructor(self, ...)
    self._id = ____exports.DamageSystem._id
    self._flag = ____exports.DamageSystem._flag
    self._aspect = ____exports.DamageSystem._aspect
    self.beginContact = function(____, a, b, contact)
        local result = check(nil, a, b, {
            hasComponent(nil, Damage),
            hasComponent(nil, Health),
        })
        if not result then
            return
        end
        local damage = result[0 + 1]:as(Damage)
        local health = result[1 + 1]:as(Health)
        if not damage or not health then
            return
        end
        health.hitpoints = health.armor - damage.hitpoints
    end
end
DamageSystem._id = "Damage"
DamageSystem._flag = SystemFlag.Damage
DamageSystem._aspect = NeverAspect.new()
return ____exports
