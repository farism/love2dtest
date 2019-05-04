--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_System = require("ecs.System")
local System = __TSTL_System.System
local Timer = require("game.utils.timer")
local __TSTL_flags = require("game.flags")
local SystemFlag = __TSTL_flags.SystemFlag
local __TSTL_Aspect = require("ecs.Aspect")
local NeverAspect = __TSTL_Aspect.NeverAspect
local __TSTL_collision = require("game.utils.collision")
local hasComponent = __TSTL_collision.hasComponent
local check = __TSTL_collision.check
local __TSTL_Player = require("game.components.Player")
local Player = __TSTL_Player.Player
local __TSTL_Platform = require("game.components.Platform")
local Platform = __TSTL_Platform.Platform
local __TSTL_Entity = require("ecs.Entity")
local Entity = __TSTL_Entity.Entity
local __TSTL_Position = require("game.components.Position")
local Position = __TSTL_Position.Position
local __TSTL_GameObject = require("game.components.GameObject")
local GameObject = __TSTL_GameObject.GameObject
local __TSTL_Waypoint = require("game.components.Waypoint")
local Waypoint = __TSTL_Waypoint.Waypoint
local reset
reset = function(____, gameObject, platform, waypoint) return function()
    local body = gameObject.fixture:getBody()
    body:setType("static")
    body:setPosition(platform.initialX, platform.initialY)
    body:setGravityScale(0)
    body:setType("kinematic")
    waypoint.active = true
    platform.timer = nil
end end
local startFalling
startFalling = function(____, entity) return function()
    local gameObject = entity:as(GameObject)
    local platform = entity:as(Platform)
    local waypoint = entity:as(Waypoint)
    if not gameObject or not platform or not waypoint then
        return
    end
    local body = gameObject.fixture:getBody()
    body:setType("dynamic")
    body:setGravityScale(1)
    waypoint.active = false
    platform.timer = Timer:setTimeout(3, reset(nil, gameObject, platform, waypoint))
end end
local fall
fall = function(____, entity)
    local platform = entity:as(Platform)
    local position = entity:as(Position)
    if not position or not platform then
        return
    end
    platform.initialX = position.x
    platform.initialY = position.y
    platform.timer = Timer:setTimeout(platform.duration, startFalling(nil, entity))
end
____exports.PlatformSystem = {}
local PlatformSystem = ____exports.PlatformSystem
PlatformSystem.name = "PlatformSystem"
PlatformSystem.__index = PlatformSystem
PlatformSystem.prototype = {}
PlatformSystem.prototype.__index = PlatformSystem.prototype
PlatformSystem.prototype.constructor = PlatformSystem
PlatformSystem.____super = System
setmetatable(PlatformSystem, PlatformSystem.____super)
setmetatable(PlatformSystem.prototype, PlatformSystem.____super.prototype)
function PlatformSystem.new(...)
    local self = setmetatable({}, PlatformSystem.prototype)
    self:____constructor(...)
    return self
end
function PlatformSystem.prototype.____constructor(self, ...)
    System.prototype.____constructor(self, ...)
    self._id = ____exports.PlatformSystem._id
    self._flag = ____exports.PlatformSystem._flag
    self._aspect = ____exports.PlatformSystem._aspect
    self.beginContact = function(____, a, b, contact)
        local result = check(nil, a, b, {
            hasComponent(nil, Platform),
            hasComponent(nil, Player),
        })
        if not result then
            return
        end
        local entity = result[0 + 1]
        local platform = entity:as(Platform)
        if platform and platform.duration > 0 and not platform.timer then
            fall(nil, entity)
        end
    end
end
PlatformSystem._id = "Platform"
PlatformSystem._flag = SystemFlag.Platform
PlatformSystem._aspect = NeverAspect.new()
return ____exports
