local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Fixture = require 'game.components.fixture'
local Input = require 'game.components.input'
local Movement = require 'game.components.movement'
local Position = require 'game.components.position'
local Respawn = require 'game.components.respawn'

local aspect = Aspect:new({Fixture, Input, Movement, Position}, {Respawn})
local InputMovement = System:new('inputmovement', aspect)

local function isPlatform(fixture)
  return fixture:getUserData().entity.meta.type == 'platform'
end

local function isPlatformContact(body)
  for _, contact in pairs(body:getContacts()) do
    local fixture1, fixture2 = contact:getFixtures()

    if isPlatform(fixture1) or isPlatform(fixture2) then
      return true
    end
  end

  return false
end

function InputMovement:update(dt)
  for _, entity in pairs(self.entities) do
    local fixture = entity:as(Fixture)
    local movement = entity:as(Movement)
    local body = fixture.fixture:getBody()
    local velocityX, velocityY = body:getLinearVelocity()
    local isPlatformContact = isPlatformContact(body)

    local newVelocityX = velocityX
    local newVelocityY = velocityY

    if (movement.left == true) then
      newVelocityX = -300
    elseif movement.right == true then
      newVelocityX = 300
    elseif not isPlatformContact then
      newVelocityX = 0
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
