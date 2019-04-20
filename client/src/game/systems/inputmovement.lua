local Aspect = require 'src.ecs.aspect'
local System = require 'src.ecs.system'
local Fixture = require 'src.game.components.fixture'
local Input = require 'src.game.components.input'
local Movement = require 'src.game.components.movement'
local Position = require 'src.game.components.position'
local Respawn = require 'src.game.components.respawn'

local aspect = Aspect.new({Fixture, Input, Movement, Position}, {Respawn})
local InputMovement = System:new('inputmovement', aspect)

function InputMovement:update(dt)
  for _, entity in pairs(self.entities) do
    local fixture = entity:as(Fixture)
    local movement = entity:as(Movement)
    local body = fixture.fixture:getBody()
    local velocityX, velocityY = body:getLinearVelocity()

    local newVelocityX = 0
    local newVelocityY = velocityY

    if (movement.left == true) then
      newVelocityX = -300
    elseif movement.right == true then
      newVelocityX = 300
    end

    if (movement.jump and movement.jumpCount < 2) then
      newVelocityY = -1000
      movement.jump = false
      movement.jumpCount = movement.jumpCount + 1
    end

    body:setLinearVelocity(newVelocityX, newVelocityY)
  end
end

return InputMovement
