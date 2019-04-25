// local vector = require 'src.vendor.vector'
// local Aspect = require 'src.ecs.aspect'
// local System = require 'src.ecs.system'
// local Attack = require 'src.game.components.attack'
// local Fixture = require 'src.game.components.fixture'
// local Movement = require 'src.game.components.movement'
// local Position = require 'src.game.components.position'
// local Waypoint = require 'src.game.components.waypoint'

// local aspect = Aspect.new({Fixture, Movement, Position, Waypoint}, {Attack})
// local WaypointMovement = System:new('waypointmovement', aspect)

// local function getNext(waypoint)
//   if waypoint.current == #waypoint.waypoints then
//     return waypoint.waypoints[1]
//   else
//     return waypoint.waypoints[waypoint.current + 1]
//   end
// end

// local function shouldAdvance(axis, velocity, position, next)
//   if not next[axis] then
//     return true
//   elseif
//     velocity > 0 and position[axis] >= next[axis] or
//       velocity < 0 and position[axis] <= next[axis] or
//       -- this is a hacky
//       math.abs(position[axis] - next[axis]) < 1
//    then
//     return true
//   else
//     return false
//   end
// end

// local function advance(waypoint)
//   if waypoint.current == #waypoint.waypoints then
//     waypoint.current = 1
//   else
//     waypoint.current = waypoint.current + 1
//   end
// end

// local function update(entity)
//   local waypoint = entity:as(Waypoint)
//   local fixture = entity:as(Fixture)
//   local movement = entity:as(Movement)
//   local position = entity:as(Position)
//   local body = fixture.fixture:getBody()
//   local velocityX, velocityY = body:getLinearVelocity()
//   local next = getNext(waypoint)
//   local shouldAdvanceX = shouldAdvance('x', velocityX, position, next)
//   local shouldAdvanceY = shouldAdvance('y', velocityY, position, next)
//   local newVelocityX = 0
//   local newVelocityY = 0
//   local angle =
//     math.atan2((next.y or position.y) - position.y, next.x - position.x)

//   body:setGravityScale(1)

//   if shouldAdvanceX and shouldAdvanceY then
//     advance(waypoint)
//   else
//     if not shouldAdvanceX then
//       newVelocityX = math.cos(angle) * waypoint.speed
//     end

//     if next.y then
//       -- if we are moving in the y direction then don't apply gravity
//       body:setGravityScale(0)

//       if not shouldAdvanceY then
//         newVelocityY = math.sin(angle) * waypoint.speed
//       end
//     else
//       newVelocityY = velocityY
//     end
//   end

//   if newVelocityX < 0 then
//     movement.direction = 'left'
//   elseif newVelocityX > 0 then
//     movement.direction = 'right'
//   end

//   body:setLinearVelocity(newVelocityX, newVelocityY)
// end

// function WaypointMovement:update(dt)
//   for _, entity in pairs(self.entities) do
//     local waypoint = entity:as(Waypoint)

//     if waypoint.active then
//       update(entity)
//     end
//   end
// end

// return WaypointMovement
