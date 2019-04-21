--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_Component = require("ecs.Component");
local Component = __TSTL_Component.Component;
local __TSTL_flags = require("game.components.flags");
local Flag = __TSTL_flags.Flag;
local TriggerType = {};
TriggerType.Spawn = "spawn";
TriggerType.spawn = "Spawn";
exports.Player = exports.Player or {};
exports.Player.__index = exports.Player;
exports.Player.prototype = exports.Player.prototype or {};
exports.Player.prototype.__index = exports.Player.prototype;
exports.Player.prototype.constructor = exports.Player;
exports.Player.____super = Component;
setmetatable(exports.Player, exports.Player.____super);
setmetatable(exports.Player.prototype, exports.Player.____super.prototype);
exports.Player.new = function(...)
    local self = setmetatable({}, exports.Player.prototype);
    self:____constructor(...);
    return self;
end;
exports.Player.prototype.____constructor = function(self, type, action)
    self._id = exports.Player._id;
    self._flag = Flag.Player;
    if type == nil then
        type = TriggerType.Spawn;
    end
    Component.prototype.____constructor(self);
    self.type = type;
    self.action = action;
    self.activated = false;
    self.executed = false;
end;
exports.Player._id = "Player";
exports.Player._flag = Flag.Player;
return exports;
