local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local constants = require 'game.systems.constants'
local Fixture = require 'game.components.fixture'
local Input = require 'game.components.input'
local Position = require 'game.components.position'
local Velocity = require 'game.components.velocity'

local aspect = Aspect:new({Position, Velocity})
local MovementSystem = System:new('movement', aspect)

function MovementSystem:update(dt)
  for _, entity in pairs(self.entities) do
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

return MovementSystem
