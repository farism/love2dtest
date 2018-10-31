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
    local movement = entity:as(Movement)
    local position = entity:as(Position)
    local waypoint = entity:as(Waypoint)
    local body = fixture.fixture:getBody()
    local current = getCurrent(waypoint)
    local next = getNext(waypoint)
    local newVelocityX = 0

    if next.x < current.x then
      movement.right = true
      newVelocityX = -50

      if (position.x < next.x) then
        advance(waypoint)
      end
    else
      movement.left = true
      newVelocityX = 50

      if (position.x > next.x) then
        advance(waypoint)
      end
    end

    local _, velocityY = body:getLinearVelocity()
    body:setLinearVelocity(newVelocityX, velocityY)
  end
end

return WaypointMovement
