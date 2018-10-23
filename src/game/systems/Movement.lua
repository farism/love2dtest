local Aspect = require('ecs/Aspect')
local System = require('ecs/System')
local constants = require('game/systems/constants')
local Fixture = require('game/components/Fixture')
local Input = require('game/components/Input')
local Position = require('game/components/Position')
local Velocity = require('game/components/Velocity')

local MovementSystem = {
  _meta = constants.Movement
}

local function noop()
end

local function update(dt, entities)
  for _, entity in pairs(entities) do
    local position = entity:as(Position)
    local velocity = entity:as(Velocity)

    if entity:has(Fixture) then
      local fixture = entity:as(Fixture)
      local body = fixture.fixture:getBody()
      local velocityX, velocityY = body:getLinearVelocity()
      position.x = body:getX()
      position.y = body:getY()

      if (entity:has(Input)) then
        local input = entity:as(Input)
        local newVelocityX = 0
        local newVelocityY = velocityY

        newVelocityX = input.left and -200 or newVelocityX
        newVelocityX = input.right and 200 or newVelocityX

        if (input.jump and input.jumps < 2) then
          newVelocityY = -500
          input.jump = false
          input.jumps = input.jumps + 1
        end

        body:setLinearVelocity(newVelocityX, newVelocityY)
      else
      end
    else
      position.x = position.x + velocity.x * dt
      position.y = position.y + velocity.y * dt
    end
  end
end

function MovementSystem:new()
  local aspect = Aspect:new({Position, Velocity})
  local system = System:new('movement', aspect, noop, update, noop)

  return system
end

return MovementSystem
