--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_conf = require("conf")
local WINDOW_HEIGHT = __TSTL_conf.WINDOW_HEIGHT
local __TSTL_System = require("ecs.System")
local System = __TSTL_System.System
local __TSTL_Aspect = require("ecs.Aspect")
local Aspect = __TSTL_Aspect.Aspect
local __TSTL_flags = require("game.flags")
local SystemFlag = __TSTL_flags.SystemFlag
local __TSTL_GameObject = require("game.components.GameObject")
local GameObject = __TSTL_GameObject.GameObject
local __TSTL_Health = require("game.components.Health")
local Health = __TSTL_Health.Health
local __TSTL_Player = require("game.components.Player")
local Player = __TSTL_Player.Player
local __TSTL_Position = require("game.components.Position")
local Position = __TSTL_Position.Position
local BUFFER = 100
____exports.FallDeathSystem = {}
local FallDeathSystem = ____exports.FallDeathSystem
FallDeathSystem.name = "FallDeathSystem"
FallDeathSystem.__index = FallDeathSystem
FallDeathSystem.prototype = {}
FallDeathSystem.prototype.__index = FallDeathSystem.prototype
FallDeathSystem.prototype.constructor = FallDeathSystem
FallDeathSystem.____super = System
setmetatable(FallDeathSystem, FallDeathSystem.____super)
setmetatable(FallDeathSystem.prototype, FallDeathSystem.____super.prototype)
function FallDeathSystem.new(...)
    local self = setmetatable({}, FallDeathSystem.prototype)
    self:____constructor(...)
    return self
end
function FallDeathSystem.prototype.____constructor(self, ...)
    System.prototype.____constructor(self, ...)
    self._id = ____exports.FallDeathSystem._id
    self._flag = ____exports.FallDeathSystem._flag
    self._aspect = ____exports.FallDeathSystem._aspect
    self.update = function(____, dt)
        self.entities:forEach(function(____, entity)
            local position = entity:as(Position)
            if position and position.y > WINDOW_HEIGHT + BUFFER then
                local health = entity:as(Health)
                if health then
                    health.hitpoints = 0
                end
            end
        end)
    end
end
FallDeathSystem._id = "FallDeath"
FallDeathSystem._flag = SystemFlag.FallDeath
FallDeathSystem._aspect = Aspect.new({
    GameObject,
    Health,
    Player,
    Position,
})
return ____exports
