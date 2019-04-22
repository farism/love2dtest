--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_component = require("ecs.component");
local Component = __TSTL_component.Component;
local __TSTL_flags = require("game.components.flags");
local Flag = __TSTL_flags.Flag;
exports.Upgrades = exports.Upgrades or {};
exports.Upgrades.__index = exports.Upgrades;
exports.Upgrades.prototype = exports.Upgrades.prototype or {};
exports.Upgrades.prototype.__index = exports.Upgrades.prototype;
exports.Upgrades.prototype.constructor = exports.Upgrades;
exports.Upgrades.new = function(...)
    local self = setmetatable({}, exports.Upgrades.prototype);
    self:____constructor(...);
    return self;
end;
exports.Upgrades.prototype.____constructor = function(self, passive, throw_, dash, grapple, dig)
    self._id = exports.Upgrades._id;
    self._flag = Flag.Upgrades;
    self.passive = passive;
    self.throw = throw_;
    self.dash = dash;
    self.grapple = grapple;
    self.dig = dig;
end;
exports.Upgrades._id = "Upgrades";
exports.Upgrades._flag = Flag.Upgrades;
return exports;
