--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_System = require("ecs.System");
local System = __TSTL_System.System;
local __TSTL_flags = require("game.flags");
local SystemFlag = __TSTL_flags.SystemFlag;
local __TSTL_collision = require("game.utils.collision");
local check = __TSTL_collision.check;
local hasComponent = __TSTL_collision.hasComponent;
local isSensor = __TSTL_collision.isSensor;
local __TSTL_Projectile = require("game.components.Projectile");
local Projectile = __TSTL_Projectile.Projectile;
exports.ProjectileSystem = exports.ProjectileSystem or {};
exports.ProjectileSystem.__index = exports.ProjectileSystem;
exports.ProjectileSystem.prototype = exports.ProjectileSystem.prototype or {};
exports.ProjectileSystem.prototype.__index = exports.ProjectileSystem.prototype;
exports.ProjectileSystem.prototype.constructor = exports.ProjectileSystem;
exports.ProjectileSystem.____super = System;
setmetatable(exports.ProjectileSystem, exports.ProjectileSystem.____super);
setmetatable(exports.ProjectileSystem.prototype, exports.ProjectileSystem.____super.prototype);
exports.ProjectileSystem.new = function(...)
    local self = setmetatable({}, exports.ProjectileSystem.prototype);
    self:____constructor(...);
    return self;
end;
exports.ProjectileSystem.prototype.____constructor = function(self, ...)
    System.prototype.____constructor(self, ...);
    self._id = exports.ProjectileSystem._id;
    self._flag = exports.ProjectileSystem._flag;
    self.beginContact = function(____, a, b, c)
        local result = check(nil, a, b, {hasComponent(nil, Projectile), isSensor});
        if result then
            result[0 + 1]:destroy();
        end
    end;
end;
exports.ProjectileSystem._id = "ProjectileSystem";
exports.ProjectileSystem._flag = SystemFlag.ProjectileSystem;
return exports;
