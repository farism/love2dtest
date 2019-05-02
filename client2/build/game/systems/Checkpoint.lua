--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_System = require("ecs.System");
local System = __TSTL_System.System;
local __TSTL_flags = require("game.flags");
local SystemFlag = __TSTL_flags.SystemFlag;
local __TSTL_Aspect = require("ecs.Aspect");
local NeverAspect = __TSTL_Aspect.NeverAspect;
local __TSTL_collision = require("game.utils.collision");
local hasComponent = __TSTL_collision.hasComponent;
local check = __TSTL_collision.check;
local __TSTL_Player = require("game.components.Player");
local Player = __TSTL_Player.Player;
local __TSTL_Checkpoint = require("game.components.Checkpoint");
local Checkpoint = __TSTL_Checkpoint.Checkpoint;
exports.CheckpointSystem = exports.CheckpointSystem or {};
exports.CheckpointSystem.__index = exports.CheckpointSystem;
exports.CheckpointSystem.prototype = exports.CheckpointSystem.prototype or {};
exports.CheckpointSystem.prototype.__index = exports.CheckpointSystem.prototype;
exports.CheckpointSystem.prototype.constructor = exports.CheckpointSystem;
exports.CheckpointSystem.____super = System;
setmetatable(exports.CheckpointSystem, exports.CheckpointSystem.____super);
setmetatable(exports.CheckpointSystem.prototype, exports.CheckpointSystem.____super.prototype);
exports.CheckpointSystem.new = function(...)
    local self = setmetatable({}, exports.CheckpointSystem.prototype);
    self:____constructor(...);
    return self;
end;
exports.CheckpointSystem.prototype.____constructor = function(self, ...)
    System.prototype.____constructor(self, ...);
    self._id = exports.CheckpointSystem._id;
    self._flag = exports.CheckpointSystem._flag;
    self._aspect = exports.CheckpointSystem._aspect;
    self.beginContact = function(____, a, b, contact)
        local result = check(nil, a, b, {hasComponent(nil, Player), hasComponent(nil, Checkpoint)});
        if result then
            local player = result[0 + 1]:as(Player);
            local checkpoint = result[1 + 1]:as(Checkpoint);
            if player and checkpoint then
                checkpoint.visited = true;
                player.checkpoint = math.max(checkpoint.index);
            end
        end
    end;
end;
exports.CheckpointSystem._id = "Checkpoint";
exports.CheckpointSystem._flag = SystemFlag.Checkpoint;
exports.CheckpointSystem._aspect = NeverAspect.new();
return exports;
