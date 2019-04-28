--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_flags = require("game.flags");
local ComponentFlag = __TSTL_flags.ComponentFlag;
local TriggerType = {};
TriggerType.Spawn = "spawn";
TriggerType.spawn = "Spawn";
exports.Player = exports.Player or {};
exports.Player.__index = exports.Player;
exports.Player.prototype = exports.Player.prototype or {};
exports.Player.prototype.__index = exports.Player.prototype;
exports.Player.prototype.constructor = exports.Player;
exports.Player.new = function(...)
    local self = setmetatable({}, exports.Player.prototype);
    self:____constructor(...);
    return self;
end;
exports.Player.prototype.____constructor = function(self, type, action)
    self._id = exports.Player._id;
    self._flag = ComponentFlag.Player;
    if type == nil then
        type = TriggerType.Spawn;
    end
    self.type = type;
    self.action = action;
    self.activated = false;
    self.executed = false;
end;
exports.Player._id = "Player";
exports.Player._flag = ComponentFlag.Player;
return exports;
