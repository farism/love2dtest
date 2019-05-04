--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_System = require("ecs.System")
local System = __TSTL_System.System
local __TSTL_manager = require("ecs.manager")
local Manager = __TSTL_manager.Manager
local __TSTL_flags = require("game.flags")
local SystemFlag = __TSTL_flags.SystemFlag
local __TSTL_Aspect = require("ecs.Aspect")
local Aspect = __TSTL_Aspect.Aspect
local __TSTL_Player = require("game.components.Player")
local Player = __TSTL_Player.Player
local __TSTL_Respawn = require("game.components.Respawn")
local Respawn = __TSTL_Respawn.Respawn
local __TSTL_Checkpoint = require("game.components.Checkpoint")
local Checkpoint = __TSTL_Checkpoint.Checkpoint
local __TSTL_timer = require("game.utils.timer")
local setTimeout = __TSTL_timer.setTimeout
local __TSTL_Entity = require("ecs.Entity")
local Entity = __TSTL_Entity.Entity
local __TSTL_GameObject = require("game.components.GameObject")
local GameObject = __TSTL_GameObject.GameObject
local __TSTL_Position = require("game.components.Position")
local Position = __TSTL_Position.Position
local findCheckpoint
findCheckpoint = function(____, index, manager)
    local entity
    manager.entities:forEach(function(____, entity)
        local checkpoint = entity:as(Checkpoint)
        if checkpoint and checkpoint.index == index then
            entity = entity
        end
    end)
    return entity
end
local resetPosition
resetPosition = function(____, entity)
    local player = entity:as(Player)
    if not player then
        return
    end
    local checkpoint = findCheckpoint(nil, player.checkpoint, entity.manager)
    if not checkpoint then
        return
    end
    local gameObject = entity:as(GameObject)
    local position = checkpoint:as(Position)
    if not position or not gameObject then
        return
    end
    local body = gameObject.fixture:getBody()
    body:setType("static")
    body:setPosition(position.x, position.y)
    body:setType("dynamic")
    entity:remove(Respawn)
end
____exports.RespawnSystem = {}
local RespawnSystem = ____exports.RespawnSystem
RespawnSystem.name = "RespawnSystem"
RespawnSystem.__index = RespawnSystem
RespawnSystem.prototype = {}
RespawnSystem.prototype.__index = RespawnSystem.prototype
RespawnSystem.prototype.constructor = RespawnSystem
RespawnSystem.____super = System
setmetatable(RespawnSystem, RespawnSystem.____super)
setmetatable(RespawnSystem.prototype, RespawnSystem.____super.prototype)
function RespawnSystem.new(...)
    local self = setmetatable({}, RespawnSystem.prototype)
    self:____constructor(...)
    return self
end
function RespawnSystem.prototype.____constructor(self, ...)
    System.prototype.____constructor(self, ...)
    self._id = ____exports.RespawnSystem._id
    self._flag = ____exports.RespawnSystem._flag
    self._aspect = ____exports.RespawnSystem._aspect
    self.update = function(____, dt)
        self.entities:forEach(function(____, entity)
            local player = entity:as(Player)
            local respawn = entity:as(Respawn)
            if not player or not respawn then
                return
            end
            respawn.timer = setTimeout(nil, respawn.duration, function()
                resetPosition(nil, entity)
            end)
        end)
    end
end
RespawnSystem._id = "Respawn"
RespawnSystem._flag = SystemFlag.Respawn
RespawnSystem._aspect = Aspect.new({Respawn})
return ____exports
