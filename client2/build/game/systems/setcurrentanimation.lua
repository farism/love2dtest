--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_System = require("ecs.System");
local System = __TSTL_System.System;
local __TSTL_Aspect = require("ecs.Aspect");
local Aspect = __TSTL_Aspect.Aspect;
local __TSTL_flags = require("game.flags");
local SystemFlag = __TSTL_flags.SystemFlag;
local __TSTL_Animation = require("game.components.Animation");
local Animation = __TSTL_Animation.Animation;
local __TSTL_Movement = require("game.components.Movement");
local Movement = __TSTL_Movement.Movement;
exports.SetCurrentAnimationSystem = exports.SetCurrentAnimationSystem or {};
exports.SetCurrentAnimationSystem.__index = exports.SetCurrentAnimationSystem;
exports.SetCurrentAnimationSystem.prototype = exports.SetCurrentAnimationSystem.prototype or {};
exports.SetCurrentAnimationSystem.prototype.__index = exports.SetCurrentAnimationSystem.prototype;
exports.SetCurrentAnimationSystem.prototype.constructor = exports.SetCurrentAnimationSystem;
exports.SetCurrentAnimationSystem.____super = System;
setmetatable(exports.SetCurrentAnimationSystem, exports.SetCurrentAnimationSystem.____super);
setmetatable(exports.SetCurrentAnimationSystem.prototype, exports.SetCurrentAnimationSystem.____super.prototype);
exports.SetCurrentAnimationSystem.new = function(...)
    local self = setmetatable({}, exports.SetCurrentAnimationSystem.prototype);
    self:____constructor(...);
    return self;
end;
exports.SetCurrentAnimationSystem.prototype.____constructor = function(self, ...)
    System.prototype.____constructor(self, ...);
    self._id = exports.SetCurrentAnimationSystem._id;
    self._flag = exports.SetCurrentAnimationSystem._flag;
    self._aspect = exports.SetCurrentAnimationSystem._aspect;
    self.update = function(____, dt)
        self.entities:forEach(function(____, entity)
            local animation = entity:as(Animation);
            local movement = entity:as(Movement);
            if (not animation) or (not movement) then
                return;
            end
            local action = "stand";
            if movement.right or movement.left then
                action = "walk";
            end
            local newAnimation = ("" .. (tostring(action) .. "_")) .. (tostring(movement.direction) .. "");
        end);
    end;
end;
exports.SetCurrentAnimationSystem._id = "SetCurrentAnimation";
exports.SetCurrentAnimationSystem._flag = SystemFlag.SetCurrentAnimation;
exports.SetCurrentAnimationSystem._aspect = Aspect.new({Animation, Movement});
return exports;
