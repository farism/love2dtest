local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Fixture = require 'game.components.fixture'
local Input = require 'game.components.input'
local Movement = require 'game.components.movement'
local Position = require 'game.components.position'
local Respawn = require 'game.components.respawn'

local aspect = Aspect.new({Fixture, Input, Movement, Position}, {Respawn})
local InputMovement = System:new('inputmovement', aspect)

-- TODO REMOVE
function InputMovement:draw(dt)
  for _, entity in pairs(self.entities) do
    local position = entity:as(Position)
    local movement = entity:as(Movement)
    local radius = 200
    local angle = movement.aim
    local direction = movement.direction == 'left' and -1 or 1
    local dx = radius * math.cos(angle) * direction
    local dy = radius * math.sin(angle)
    love.graphics.setColor(255, 0, 0, 1)
    love.graphics.line(position.x, position.y, position.x + dx, position.y + dy)
    love.graphics.setColor(255, 255, 255, 1)
  end
end

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

    local angleIncrement = 0.05

    if (movement.lookUp) then
      movement.aim = movement.aim - angleIncrement
    end

    if (movement.lookDown) then
      movement.aim = movement.aim + angleIncrement
    end

    body:setLinearVelocity(newVelocityX, newVelocityY)
  end
end

return InputMovement
