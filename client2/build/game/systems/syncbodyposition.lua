--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_System = require("ecs.System")
local System = __TSTL_System.System
local __TSTL_flags = require("game.flags")
local SystemFlag = __TSTL_flags.SystemFlag
local __TSTL_Aspect = require("ecs.Aspect")
local Aspect = __TSTL_Aspect.Aspect
local __TSTL_GameObject = require("game.components.GameObject")
local GameObject = __TSTL_GameObject.GameObject
local __TSTL_Position = require("game.components.Position")
local Position = __TSTL_Position.Position
____exports.SyncBodyPositionSystem = {}
local SyncBodyPositionSystem = ____exports.SyncBodyPositionSystem
SyncBodyPositionSystem.name = "SyncBodyPositionSystem"
SyncBodyPositionSystem.__index = SyncBodyPositionSystem
SyncBodyPositionSystem.prototype = {}
SyncBodyPositionSystem.prototype.__index = SyncBodyPositionSystem.prototype
SyncBodyPositionSystem.prototype.constructor = SyncBodyPositionSystem
SyncBodyPositionSystem.____super = System
setmetatable(SyncBodyPositionSystem, SyncBodyPositionSystem.____super)
setmetatable(SyncBodyPositionSystem.prototype, SyncBodyPositionSystem.____super.prototype)
function SyncBodyPositionSystem.new(...)
    local self = setmetatable({}, SyncBodyPositionSystem.prototype)
    self:____constructor(...)
    return self
end
function SyncBodyPositionSystem.prototype.____constructor(self, ...)
    System.prototype.____constructor(self, ...)
    self._id = ____exports.SyncBodyPositionSystem._id
    self._flag = ____exports.SyncBodyPositionSystem._flag
    self._aspect = ____exports.SyncBodyPositionSystem._aspect
    self.update = function(____, dt)
        self.entities:forEach(function(____, entity)
            local gameObject = entity:as(GameObject)
            local position = entity:as(Position)
            if not gameObject or not position then
                return
            end
            local body = gameObject.fixture:getBody()
            local x, y = body:getPosition()
            position.x = x
            position.y = y
        end)
    end
end
SyncBodyPositionSystem._id = "SyncBodyPosition"
SyncBodyPositionSystem._flag = SystemFlag.SyncBodyPosition
SyncBodyPositionSystem._aspect = Aspect.new({
    GameObject,
    Position,
})
return ____exports
