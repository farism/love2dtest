--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_flags = require("game.flags");
local ComponentFlag = __TSTL_flags.ComponentFlag;
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
    self._flag = ComponentFlag.Projectile;
end;
exports.Projectile._id = "Projectile";
exports.Projectile._flag = ComponentFlag.Projectile;
return exports;
