--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_System = require("ecs.System");
local System = __TSTL_System.System;
local __TSTL_flags = require("game.flags");
local SystemFlag = __TSTL_flags.SystemFlag;
local __TSTL_Aspect = require("ecs.Aspect");
local NeverAspect = __TSTL_Aspect.NeverAspect;
local __TSTL_collision = require("game.utils.collision");
local check = __TSTL_collision.check;
local hasComponent = __TSTL_collision.hasComponent;
local isNotBodyType = __TSTL_collision.isNotBodyType;
local __TSTL_Damage = require("game.components.Damage");
local Damage = __TSTL_Damage.Damage;
local __TSTL_Health = require("game.components.Health");
local Health = __TSTL_Health.Health;
exports.DamageSystem = exports.DamageSystem or {};
exports.DamageSystem.__index = exports.DamageSystem;
exports.DamageSystem.prototype = exports.DamageSystem.prototype or {};
exports.DamageSystem.prototype.__index = exports.DamageSystem.prototype;
exports.DamageSystem.prototype.constructor = exports.DamageSystem;
exports.DamageSystem.____super = System;
setmetatable(exports.DamageSystem, exports.DamageSystem.____super);
setmetatable(exports.DamageSystem.prototype, exports.DamageSystem.____super.prototype);
exports.DamageSystem.new = function(...)
    local self = setmetatable({}, exports.DamageSystem.prototype);
    self:____constructor(...);
    return self;
end;
exports.DamageSystem.prototype.____constructor = function(self, ...)
    System.prototype.____constructor(self, ...);
    self._id = exports.DamageSystem._id;
    self._flag = exports.DamageSystem._flag;
    self._aspect = exports.DamageSystem._aspect;
    self.beginContact = function(____, a, b, contact)
        local result = check(nil, a, b, {hasComponent(nil, Damage), hasComponent(nil, Health)});
        if not result then
            return;
        end
        local damage = result[0 + 1]:as(Damage);
        local health = result[0 + 1]:as(Health);
        if damage and health then
            health.hitpoints = health.armor - damage.hitpoints;
        end
    end;
end;
exports.DamageSystem._id = "Damage";
exports.DamageSystem._flag = SystemFlag.Damage;
exports.DamageSystem._aspect = NeverAspect.new();
return exports;
