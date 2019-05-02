--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_System = require("ecs.System");
local System = __TSTL_System.System;
local __TSTL_flags = require("game.flags");
local SystemFlag = __TSTL_flags.SystemFlag;
local __TSTL_Aspect = require("ecs.Aspect");
local Aspect = __TSTL_Aspect.Aspect;
local __TSTL_collision = require("game.utils.collision");
local check = __TSTL_collision.check;
local hasComponent = __TSTL_collision.hasComponent;
local __TSTL_Trigger = require("game.components.Trigger");
local Trigger = __TSTL_Trigger.Trigger;
local __TSTL_Player = require("game.components.Player");
local Player = __TSTL_Player.Player;
exports.TriggerSystem = exports.TriggerSystem or {};
exports.TriggerSystem.__index = exports.TriggerSystem;
exports.TriggerSystem.prototype = exports.TriggerSystem.prototype or {};
exports.TriggerSystem.prototype.__index = exports.TriggerSystem.prototype;
exports.TriggerSystem.prototype.constructor = exports.TriggerSystem;
exports.TriggerSystem.____super = System;
setmetatable(exports.TriggerSystem, exports.TriggerSystem.____super);
setmetatable(exports.TriggerSystem.prototype, exports.TriggerSystem.____super.prototype);
exports.TriggerSystem.new = function(...)
    local self = setmetatable({}, exports.TriggerSystem.prototype);
    self:____constructor(...);
    return self;
end;
exports.TriggerSystem.prototype.____constructor = function(self, ...)
    System.prototype.____constructor(self, ...);
    self._id = exports.TriggerSystem._id;
    self._flag = exports.TriggerSystem._flag;
    self._aspect = exports.TriggerSystem._aspect;
    self.update = function(____, dt)
        self.entities:forEach(function(____, entity)
            local trigger = entity:as(Trigger);
            if (trigger and trigger.activated) and (not trigger.executed) then
                trigger:action();
                trigger.executed = true;
            end
        end);
    end;
    self.beginContact = function(____, a, b, contact)
        local result = check(nil, a, b, {hasComponent(nil, Trigger), hasComponent(nil, Player)});
        if not result then
            return;
        end
        local trigger = result[0 + 1]:as(Trigger);
        if trigger then
            trigger.activated = true;
        end
    end;
end;
exports.TriggerSystem._id = "Trigger";
exports.TriggerSystem._flag = SystemFlag.Trigger;
exports.TriggerSystem._aspect = Aspect.new({Trigger});
return exports;
