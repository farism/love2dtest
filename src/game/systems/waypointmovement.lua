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

function WaypointMovement:update(dt)
  for _, entity in pairs(self.entities) do
    local fixture = entity:as(Fixture)
    local position = entity:as(Position)
    local waypoint = entity:as(Waypoint)
    local body = fixture.fixture:getBody()
    local current = getCurrent(waypoint)
    local next = getNext(waypoint)
    local angle = math.atan2(next.y - position.y, next.x - position.x)
    local velocityX = math.cos(angle)
    local velocityY = math.sin(angle)
    local advanceX = false
    local advanceY = false

    if (next.x >= current.x and position.x >= next.x) then -- moving left
      advanceX = true
    elseif (next.x <= current.x and position.x <= next.x) then -- moving right
      advanceX = true
    end

    if (next.y >= current.y and position.y >= next.y) then -- moving up
      advanceY = true
    elseif (next.y <= current.y and position.y <= next.y) then -- moving down
      advanceY = true
    end

    if (advanceX and advanceY) then
      advance(waypoint)
    end

    body:setLinearVelocity(
      velocityX * waypoint.speed,
      velocityY * waypoint.speed
    )
  end
end

return WaypointMovement
