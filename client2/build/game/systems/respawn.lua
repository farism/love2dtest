--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_System = require("ecs.System");
local System = __TSTL_System.System;
local __TSTL_manager = require("ecs.manager");
local Manager = __TSTL_manager.Manager;
local __TSTL_flags = require("game.flags");
local SystemFlag = __TSTL_flags.SystemFlag;
local __TSTL_Aspect = require("ecs.Aspect");
local Aspect = __TSTL_Aspect.Aspect;
local __TSTL_Player = require("game.components.Player");
local Player = __TSTL_Player.Player;
local __TSTL_Respawn = require("game.components.Respawn");
local Respawn = __TSTL_Respawn.Respawn;
local __TSTL_Checkpoint = require("game.components.Checkpoint");
local Checkpoint = __TSTL_Checkpoint.Checkpoint;
local findCheckpoint;
findCheckpoint = function(____, index, manager)
    local entity;
    manager.entities:forEach(function(____, entity)
        local checkpoint = entity:as(Checkpoint);
        if checkpoint and checkpoint.index then
            entity = entity;
        end
    end);
    return entity;
end;
exports.RespawnSystem = exports.RespawnSystem or {};
exports.RespawnSystem.__index = exports.RespawnSystem;
exports.RespawnSystem.prototype = exports.RespawnSystem.prototype or {};
exports.RespawnSystem.prototype.__index = exports.RespawnSystem.prototype;
exports.RespawnSystem.prototype.constructor = exports.RespawnSystem;
exports.RespawnSystem.____super = System;
setmetatable(exports.RespawnSystem, exports.RespawnSystem.____super);
setmetatable(exports.RespawnSystem.prototype, exports.RespawnSystem.____super.prototype);
exports.RespawnSystem.new = function(...)
    local self = setmetatable({}, exports.RespawnSystem.prototype);
    self:____constructor(...);
    return self;
end;
exports.RespawnSystem.prototype.____constructor = function(self, ...)
    System.prototype.____constructor(self, ...);
    self._id = exports.RespawnSystem._id;
    self._flag = exports.RespawnSystem._flag;
    self._aspect = exports.RespawnSystem._aspect;
    self.update = function(____, dt)
        self.entities:forEach(function(____, entity)
            local player = entity:as(Player);
            local respawn = entity:as(Respawn);
            if player and respawn then
                if respawn.waitTime then
                end
            end
        end);
    end;
end;
exports.RespawnSystem._id = "Respawn";
exports.RespawnSystem._flag = SystemFlag.Respawn;
exports.RespawnSystem._aspect = Aspect.new({Respawn});
return exports;
