local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Attack = require 'game.components.attack'
local Aggression = require 'game.components.aggression'
local Fixture = require 'game.components.fixture'
local Position = require 'game.components.position'
local collision = require 'game.utils.collision'

local aspect = Aspect:new({Aggression, Fixture, Position})
local AggressionSystem = System:new('aggression', aspect)

function AggressionSystem:update(dt)
  for _, entity in pairs(self.entities) do
    local aggression = entity:as(Aggression)
    local fixture = entity:as(Fixture)

    aggression.fixture:getBody():setPosition(
      fixture.fixture:getBody():getPosition()
    )
  end
end

function AggressionSystem:draw()
  for _, entity in pairs(self.entities) do
    local aggression = entity:as(Aggression)
    local body = aggression.fixture:getBody()
    local shape = aggression.fixture:getShape()
    local shapeType = shape:getType()

    love.graphics.setColor(255, 0, 0, 0.25)
    love.graphics.polygon('fill', body:getWorldPoints(shape:getPoints()))
    love.graphics.setColor(255, 255, 255, 1)
  end
end

function AggressionSystem:collision(a, b, contact)
  if collision.is('player', a) and collision.isAggression(b) then
    collision.entity(b):addComponent(Attack.new(1, collision.entity(a)))
  elseif collision.isAggression(a) and collision.is('player', b) then
    collision.entity(a):addComponent(Attack.new(1, collision.entity(b)))
  end
end

return AggressionSystem
