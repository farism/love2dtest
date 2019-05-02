--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_flags = require("game.flags");
local ComponentFlag = __TSTL_flags.ComponentFlag;
local TriggerType = {};
TriggerType.Spawn = "spawn";
TriggerType.spawn = "Spawn";
exports.Trigger = exports.Trigger or {};
exports.Trigger.__index = exports.Trigger;
exports.Trigger.prototype = exports.Trigger.prototype or {};
exports.Trigger.prototype.__index = exports.Trigger.prototype;
exports.Trigger.prototype.constructor = exports.Trigger;
exports.Trigger.new = function(...)
    local self = setmetatable({}, exports.Trigger.prototype);
    self:____constructor(...);
    return self;
end;
exports.Trigger.prototype.____constructor = function(self, type, action)
    self._id = exports.Trigger._id;
    self._flag = ComponentFlag.Trigger;
    if type == nil then
        type = TriggerType.Spawn;
    end
    self.type = type;
    self.action = action;
    self.activated = false;
    self.executed = false;
end;
exports.Trigger._id = "Trigger";
exports.Trigger._flag = ComponentFlag.Trigger;
return exports;
