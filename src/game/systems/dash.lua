local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Dash = require 'game.components.dash'
local Fixture = require 'game.components.fixture'
local Input = require 'game.components.input'
local Movement = require 'game.components.movement'
local Position = require 'game.components.position'

local aspect = Aspect:new({Dash})
local DashSystem = System:new('dash', aspect)

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

    dash.duration = dash.duration - dt

    if (dash.duration <= 0) then
      self.manager:removeComponent(entity, dash)
    end
  end
end

return DashSystem
