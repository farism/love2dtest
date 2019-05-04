--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_System = require("ecs.System")
local System = __TSTL_System.System
local __TSTL_flags = require("game.flags")
local SystemFlag = __TSTL_flags.SystemFlag
local __TSTL_Aspect = require("ecs.Aspect")
local Aspect = __TSTL_Aspect.Aspect
local __TSTL_Waypoint = require("game.components.Waypoint")
local Waypoint = __TSTL_Waypoint.Waypoint
local Point = __TSTL_Waypoint.Point
local __TSTL_Movement = require("game.components.Movement")
local Movement = __TSTL_Movement.Movement
local Direction = __TSTL_Movement.Direction
local __TSTL_Position = require("game.components.Position")
local Position = __TSTL_Position.Position
local __TSTL_GameObject = require("game.components.GameObject")
local GameObject = __TSTL_GameObject.GameObject
local __TSTL_Attack = require("game.components.Attack")
local Attack = __TSTL_Attack.Attack
local Axis = {}
Axis.X = "x"
Axis.x = "X"
Axis.Y = "y"
Axis.y = "Y"
local shouldAdvance
shouldAdvance = function(____, axis, velocity, position, next)
    if not next[axis] then
        return true
    elseif velocity > 0 and position[axis] >= next[axis] then
        return true
    else
        return false
    end
end
local advance
advance = function(____, waypoint)
    if waypoint.current == #waypoint.path then
        waypoint.current = 0
    else
        waypoint.current = waypoint.current + 1
    end
end
local getNext
getNext = function(____, waypoint)
    local point = #waypoint.path and waypoint.path[0 + 1] or waypoint.path[(waypoint.current + 1) + 1]
    return point and point or {
        x = 0,
        y = 0,
    }
end
____exports.WaypointMovementSystem = {}
local WaypointMovementSystem = ____exports.WaypointMovementSystem
WaypointMovementSystem.name = "WaypointMovementSystem"
WaypointMovementSystem.__index = WaypointMovementSystem
WaypointMovementSystem.prototype = {}
WaypointMovementSystem.prototype.__index = WaypointMovementSystem.prototype
WaypointMovementSystem.prototype.constructor = WaypointMovementSystem
WaypointMovementSystem.____super = System
setmetatable(WaypointMovementSystem, WaypointMovementSystem.____super)
setmetatable(WaypointMovementSystem.prototype, WaypointMovementSystem.____super.prototype)
function WaypointMovementSystem.new(...)
    local self = setmetatable({}, WaypointMovementSystem.prototype)
    self:____constructor(...)
    return self
end
function WaypointMovementSystem.prototype.____constructor(self, ...)
    System.prototype.____constructor(self, ...)
    self._id = ____exports.WaypointMovementSystem._id
    self._flag = ____exports.WaypointMovementSystem._flag
    self._aspect = ____exports.WaypointMovementSystem._aspect
    self.update = function(____, dt)
        self.entities:forEach(function(____, entity)
            local waypoint = entity:as(Waypoint)
            local gameObject = entity:as(GameObject)
            local movement = entity:as(Movement)
            local position = entity:as(Position)
            if not waypoint or not gameObject or not movement or not position then
                return
            end
            if not waypoint.active then
                return
            end
            local body = gameObject.fixture:getBody()
            body:setGravityScale(1)
            local next = getNext(nil, waypoint)
            local angle = math.atan2((next.y or position.y) - position.y, next.x - position.x)
            local velocityX, velocityY = body:getLinearVelocity()
            local shouldAdvanceX = shouldAdvance(nil, Axis.X, velocityX, position, next)
            local shouldAdvanceY = shouldAdvance(nil, Axis.Y, velocityY, position, next)
            local newVelocityX = 0
            local newVelocityY = 0
            if shouldAdvanceX and shouldAdvanceY then
                advance(nil, waypoint)
            else
                if not shouldAdvanceX then
                    newVelocityX = math.cos(angle) * waypoint.speed
                end
                if next.y then
                    body:setGravityScale(0)
                    if not shouldAdvanceY then
                        newVelocityY = math.sin(angle) * waypoint.speed
                    end
                else
                    newVelocityY = velocityY
                end
            end
            if newVelocityX < 0 then
                movement.direction = Direction.Left
            elseif newVelocityX > 0 then
                movement.direction = Direction.Right
            end
            body:setLinearVelocity(newVelocityX, newVelocityY)
        end)
    end
end
WaypointMovementSystem._id = "WaypointMovement"
WaypointMovementSystem._flag = SystemFlag.WaypointMovement
WaypointMovementSystem._aspect = Aspect.new({
    GameObject,
    Movement,
    Position,
    Waypoint,
}, {})
return ____exports
