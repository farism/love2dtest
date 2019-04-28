--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_System = require("ecs.System");
local System = __TSTL_System.System;
local __TSTL_flags = require("game.flags");
local SystemFlag = __TSTL_flags.SystemFlag;
exports.Projectile = exports.Projectile or {};
exports.Projectile.__index = exports.Projectile;
exports.Projectile.prototype = exports.Projectile.prototype or {};
exports.Projectile.prototype.__index = exports.Projectile.prototype;
exports.Projectile.prototype.constructor = exports.Projectile;
exports.Projectile.____super = System;
setmetatable(exports.Projectile, exports.Projectile.____super);
setmetatable(exports.Projectile.prototype, exports.Projectile.____super.prototype);
exports.Projectile.new = function(...)
    local self = setmetatable({}, exports.Projectile.prototype);
    self:____constructor(...);
    return self;
end;
exports.Projectile.prototype.____constructor = function(self, ...)
    System.prototype.____constructor(self, ...);
    self._id = exports.Projectile._id;
    self._flag = exports.Projectile._flag;
    self.beginContact = function(____, a, b, c)
    end;
end;
exports.Projectile._id = "Projectile";
exports.Projectile._flag = SystemFlag.Projectile;
return exports;
