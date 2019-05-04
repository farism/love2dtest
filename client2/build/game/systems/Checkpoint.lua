--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_System = require("ecs.System")
local System = __TSTL_System.System
local __TSTL_flags = require("game.flags")
local SystemFlag = __TSTL_flags.SystemFlag
local __TSTL_Aspect = require("ecs.Aspect")
local NeverAspect = __TSTL_Aspect.NeverAspect
local __TSTL_collision = require("game.utils.collision")
local hasComponent = __TSTL_collision.hasComponent
local check = __TSTL_collision.check
local __TSTL_Player = require("game.components.Player")
local Player = __TSTL_Player.Player
local __TSTL_Checkpoint = require("game.components.Checkpoint")
local Checkpoint = __TSTL_Checkpoint.Checkpoint
____exports.CheckpointSystem = {}
local CheckpointSystem = ____exports.CheckpointSystem
CheckpointSystem.name = "CheckpointSystem"
CheckpointSystem.__index = CheckpointSystem
CheckpointSystem.prototype = {}
CheckpointSystem.prototype.__index = CheckpointSystem.prototype
CheckpointSystem.prototype.constructor = CheckpointSystem
CheckpointSystem.____super = System
setmetatable(CheckpointSystem, CheckpointSystem.____super)
setmetatable(CheckpointSystem.prototype, CheckpointSystem.____super.prototype)
function CheckpointSystem.new(...)
    local self = setmetatable({}, CheckpointSystem.prototype)
    self:____constructor(...)
    return self
end
function CheckpointSystem.prototype.____constructor(self, ...)
    System.prototype.____constructor(self, ...)
    self._id = ____exports.CheckpointSystem._id
    self._flag = ____exports.CheckpointSystem._flag
    self._aspect = ____exports.CheckpointSystem._aspect
    self.beginContact = function(____, a, b, contact)
        local result = check(nil, a, b, {
            hasComponent(nil, Player),
            hasComponent(nil, Checkpoint),
        })
        if result then
            local player = result[0 + 1]:as(Player)
            local checkpoint = result[1 + 1]:as(Checkpoint)
            if player and checkpoint then
                checkpoint.visited = true
                player.checkpoint = math.max(checkpoint.index)
            end
        end
    end
end
CheckpointSystem._id = "Checkpoint"
CheckpointSystem._flag = SystemFlag.Checkpoint
CheckpointSystem._aspect = NeverAspect.new()
return ____exports
