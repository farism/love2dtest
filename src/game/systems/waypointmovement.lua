local vector = require 'vendor.vector'
local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Fixture = require 'game.components.fixture'
local Movement = require 'game.components.movement'
local Position = require 'game.components.position'
local Timer = require 'game.components.timer'
local Waypoint = require 'game.components.waypoint'

local aspect = Aspect:new({Fixture, Movement, Position, Timer, Waypoint})
local WaypointMovement = System:new('waypointmovement', aspect)

local function getCurrent(waypoint)
  return waypoint.waypoints[waypoint.current]
end

local function getNext(waypoint)
  if waypoint.current == #waypoint.waypoints then
    return waypoint.waypoints[1]
  else
    return waypoint.waypoints[waypoint.current + 1]
  end
end

local function advance(waypoint)
  if waypoint.current == #waypoint.waypoints then
    waypoint.current = 1
  else
    waypoint.current = waypoint.current + 1
  end
end

local function shouldAdvance(axis, velocity, position, next)
  if not next[axis] then
    return true
  elseif
    velocity > 0 and position[axis] >= next[axis] or
      velocity < 0 and position[axis] <= next[axis] or
      -- this is hacky
      math.abs(position[axis] - next[axis]) < 1
   then
    return true
  else
    return false
  end
end

function WaypointMovement:update(dt)
  for _, entity in pairs(self.entities) do
    local fixture = entity:as(Fixture)
    local position = entity:as(Position)
    local waypoint = entity:as(Waypoint)
    local body = fixture.fixture:getBody()
    local velocityX, velocityY = body:getLinearVelocity()
    local current = getCurrent(waypoint)
    local next = getNext(waypoint)
    local shouldAdvanceX = shouldAdvance('x', velocityX, position, next)
    local shouldAdvanceY = shouldAdvance('y', velocityY, position, next)
    local newVelocityX = 0
    local newVelocityY = 0
    local angle =
      math.atan2((next.y or position.y) - position.y, next.x - position.x)

    body:setGravityScale(1)

    if shouldAdvanceX and shouldAdvanceY then
      advance(waypoint)
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

    body:setLinearVelocity(newVelocityX, newVelocityY)
  end
end

return WaypointMovement
