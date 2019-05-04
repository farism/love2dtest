--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_System = require("ecs.System")
local System = __TSTL_System.System
local __TSTL_flags = require("game.flags")
local SystemFlag = __TSTL_flags.SystemFlag
local __TSTL_Aspect = require("ecs.Aspect")
local Aspect = __TSTL_Aspect.Aspect
local __TSTL_collision = require("game.utils.collision")
local check = __TSTL_collision.check
local hasComponent = __TSTL_collision.hasComponent
local __TSTL_Trigger = require("game.components.Trigger")
local Trigger = __TSTL_Trigger.Trigger
local __TSTL_Player = require("game.components.Player")
local Player = __TSTL_Player.Player
____exports.TriggerSystem = {}
local TriggerSystem = ____exports.TriggerSystem
TriggerSystem.name = "TriggerSystem"
TriggerSystem.__index = TriggerSystem
TriggerSystem.prototype = {}
TriggerSystem.prototype.__index = TriggerSystem.prototype
TriggerSystem.prototype.constructor = TriggerSystem
TriggerSystem.____super = System
setmetatable(TriggerSystem, TriggerSystem.____super)
setmetatable(TriggerSystem.prototype, TriggerSystem.____super.prototype)
function TriggerSystem.new(...)
    local self = setmetatable({}, TriggerSystem.prototype)
    self:____constructor(...)
    return self
end
function TriggerSystem.prototype.____constructor(self, ...)
    System.prototype.____constructor(self, ...)
    self._id = ____exports.TriggerSystem._id
    self._flag = ____exports.TriggerSystem._flag
    self._aspect = ____exports.TriggerSystem._aspect
    self.update = function(____, dt)
        self.entities:forEach(function(____, entity)
            local trigger = entity:as(Trigger)
            if trigger and trigger.activated and not trigger.executed then
                trigger:action()
                trigger.executed = true
            end
        end)
    end
    self.beginContact = function(____, a, b, contact)
        local result = check(nil, a, b, {
            hasComponent(nil, Trigger),
            hasComponent(nil, Player),
        })
        if not result then
            return
        end
        local trigger = result[0 + 1]:as(Trigger)
        if trigger then
            trigger.activated = true
        end
    end
end
TriggerSystem._id = "Trigger"
TriggerSystem._flag = SystemFlag.Trigger
TriggerSystem._aspect = Aspect.new({Trigger})
return ____exports
