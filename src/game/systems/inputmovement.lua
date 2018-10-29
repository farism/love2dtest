local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Dash = require 'game.components.dash'
local Dig = require 'game.components.dig'
local Fixture = require 'game.components.fixture'
local Input = require 'game.components.input'
local Movement = require 'game.components.movement'
local Position = require 'game.components.position'

local aspect = Aspect:new({Fixture, Input, Movement, Position}, {Dash, Dig})
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
      newVelocityX = -200
    elseif movement.right == true then
      newVelocityX = 200
    end

    if (movement.jump and movement.jumpCount < 2) then
      newVelocityY = -500
      movement.jump = false
      movement.jumpCount = movement.jumpCount + 1
    end

    body:setLinearVelocity(newVelocityX, newVelocityY)
  end
end

return InputMovement
