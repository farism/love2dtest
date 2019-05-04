--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_flags = require("game.flags")
local ComponentFlag = __TSTL_flags.ComponentFlag
local TriggerType = {}
TriggerType.Spawn = "spawn"
TriggerType.spawn = "Spawn"
____exports.Trigger = {}
local Trigger = ____exports.Trigger
Trigger.name = "Trigger"
Trigger.__index = Trigger
Trigger.prototype = {}
Trigger.prototype.__index = Trigger.prototype
Trigger.prototype.constructor = Trigger
function Trigger.new(...)
    local self = setmetatable({}, Trigger.prototype)
    self:____constructor(...)
    return self
end
function Trigger.prototype.____constructor(self, type, action)
    self._id = ____exports.Trigger._id
    self._flag = ComponentFlag.Trigger
    if type == nil then
        type = TriggerType.Spawn
    end
    self.type = type
    self.action = action
    self.activated = false
    self.executed = false
end
Trigger._id = "Trigger"
Trigger._flag = ComponentFlag.Trigger
return ____exports
