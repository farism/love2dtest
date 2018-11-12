local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Dash = require 'game.components.dash'
local Fixture = require 'game.components.fixture'
local Movement = require 'game.components.movement'

local aspect = Aspect:new({Dash, Fixture, Movement})
local DashSystem = System:new('dash', aspect)

function DashSystem:onAdd(entity)
  entity:as(Fixture).fixture:getBody():setGravityScale(0)
end

function DashSystem:onRemove(entity)
  entity:as(Fixture).fixture:getBody():setGravityScale(1)
end

function DashSystem:update(dt)
  for _, entity in pairs(self.entities) do
    local dash = entity:as(Dash)
    local fixture = entity:as(Fixture)
    local movement = entity:as(Movement)
    local body = fixture.fixture:getBody()
    local velocityX, velocityY = body:getLinearVelocity()
    if (movement.direction == 'left') then
      body:setLinearVelocity(-2000, 0)
    elseif movement.direction == 'right' then
      body:setLinearVelocity(2000, 0)
    end
  end
end

return DashSystem
