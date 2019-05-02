--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_System = require("ecs.System");
local System = __TSTL_System.System;
local __TSTL_flags = require("game.flags");
local SystemFlag = __TSTL_flags.SystemFlag;
local __TSTL_Aspect = require("ecs.Aspect");
local Aspect = __TSTL_Aspect.Aspect;
local __TSTL_Player = require("game.components.Player");
local Player = __TSTL_Player.Player;
local __TSTL_State = require("game.State");
local State = __TSTL_State.State;
exports.GameOverSystem = exports.GameOverSystem or {};
exports.GameOverSystem.__index = exports.GameOverSystem;
exports.GameOverSystem.prototype = exports.GameOverSystem.prototype or {};
exports.GameOverSystem.prototype.__index = exports.GameOverSystem.prototype;
exports.GameOverSystem.prototype.constructor = exports.GameOverSystem;
exports.GameOverSystem.____super = System;
setmetatable(exports.GameOverSystem, exports.GameOverSystem.____super);
setmetatable(exports.GameOverSystem.prototype, exports.GameOverSystem.____super.prototype);
exports.GameOverSystem.new = function(...)
    local self = setmetatable({}, exports.GameOverSystem.prototype);
    self:____constructor(...);
    return self;
end;
exports.GameOverSystem.prototype.____constructor = function(self, ...)
    System.prototype.____constructor(self, ...);
    self._id = exports.GameOverSystem._id;
    self._flag = exports.GameOverSystem._flag;
    self._aspect = exports.GameOverSystem._aspect;
    self.update = function(____, dt)
        self.entities:forEach(function(____, entity)
            local player = entity:as(Player);
            if player and (player.lives == 0) then
            end
        end);
    end;
end;
exports.GameOverSystem._id = "GameOver";
exports.GameOverSystem._flag = SystemFlag.GameOver;
exports.GameOverSystem._aspect = Aspect.new({Player});
return exports;
