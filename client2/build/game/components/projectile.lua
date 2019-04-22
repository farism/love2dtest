--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_Component = require("ecs.Component");
local Component = __TSTL_Component.Component;
local __TSTL_flags = require("game.components.flags");
local Flag = __TSTL_flags.Flag;
exports.Projectile = exports.Projectile or {};
exports.Projectile.__index = exports.Projectile;
exports.Projectile.prototype = exports.Projectile.prototype or {};
exports.Projectile.prototype.__index = exports.Projectile.prototype;
exports.Projectile.prototype.constructor = exports.Projectile;
exports.Projectile.new = function(...)
    local self = setmetatable({}, exports.Projectile.prototype);
    self:____constructor(...);
    return self;
end;
exports.Projectile.prototype.____constructor = function(self)
    self._id = exports.Projectile._id;
    self._flag = Flag.Projectile;
end;
exports.Projectile._id = "Projectile";
exports.Projectile._flag = Flag.Projectile;
return exports;
