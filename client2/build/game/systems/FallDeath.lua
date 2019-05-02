--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_conf = require("conf");
local WINDOW_HEIGHT = __TSTL_conf.WINDOW_HEIGHT;
local __TSTL_System = require("ecs.System");
local System = __TSTL_System.System;
local __TSTL_Aspect = require("ecs.Aspect");
local Aspect = __TSTL_Aspect.Aspect;
local __TSTL_flags = require("game.flags");
local SystemFlag = __TSTL_flags.SystemFlag;
local __TSTL_GameObject = require("game.components.GameObject");
local GameObject = __TSTL_GameObject.GameObject;
local __TSTL_Health = require("game.components.Health");
local Health = __TSTL_Health.Health;
local __TSTL_Player = require("game.components.Player");
local Player = __TSTL_Player.Player;
local __TSTL_Position = require("game.components.Position");
local Position = __TSTL_Position.Position;
local BUFFER = 100;
exports.FallDeathSystem = exports.FallDeathSystem or {};
exports.FallDeathSystem.__index = exports.FallDeathSystem;
exports.FallDeathSystem.prototype = exports.FallDeathSystem.prototype or {};
exports.FallDeathSystem.prototype.__index = exports.FallDeathSystem.prototype;
exports.FallDeathSystem.prototype.constructor = exports.FallDeathSystem;
exports.FallDeathSystem.____super = System;
setmetatable(exports.FallDeathSystem, exports.FallDeathSystem.____super);
setmetatable(exports.FallDeathSystem.prototype, exports.FallDeathSystem.____super.prototype);
exports.FallDeathSystem.new = function(...)
    local self = setmetatable({}, exports.FallDeathSystem.prototype);
    self:____constructor(...);
    return self;
end;
exports.FallDeathSystem.prototype.____constructor = function(self, ...)
    System.prototype.____constructor(self, ...);
    self._id = exports.FallDeathSystem._id;
    self._flag = exports.FallDeathSystem._flag;
    self._aspect = exports.FallDeathSystem._aspect;
    self.update = function(____, dt)
        self.entities:forEach(function(____, entity)
            local position = entity:as(Position);
            if position and (position.y > (WINDOW_HEIGHT + BUFFER)) then
                local health = entity:as(Health);
                if health then
                    health.hitpoints = 0;
                end
            end
        end);
    end;
end;
exports.FallDeathSystem._id = "FallDeath";
exports.FallDeathSystem._flag = SystemFlag.FallDeath;
exports.FallDeathSystem._aspect = Aspect.new({GameObject, Health, Player, Position});
return exports;
