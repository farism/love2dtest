local cron = require 'src.vendor.cron'
local Aspect = require 'src.ecs.aspect'
local System = require 'src.ecs.system'
local Attack = require 'src.game.components.attack'
local Aggression = require 'src.game.components.aggression'
local Fixture = require 'src.game.components.fixture'
local Position = require 'src.game.components.position'
local collision = require 'src.game.utils.collision'

local aspect = Aspect.new({Aggression, Fixture, Position})
local AggressionSystem = System:new('aggression', aspect)

function startAttack(origin, target)
  origin = collision.entity(origin)
  target = collision.entity(target)
  origin:add(Attack.new(1, target))
end

function stopAttack(origin)
  origin = collision.entity(origin)
  local aggression = origin:as(Aggression)
  local callback = function()
    origin:remove(Attack)
    aggression.timeout = nil
  end
  aggression.timeout = cron.after(aggression.duration, callback)
end

function AggressionSystem:update(dt)
  for _, entity in pairs(self.entities) do
    local aggression = entity:as(Aggression)
    local fixture = entity:as(Fixture)

    if aggression.timeout then
      aggression.timeout:update(dt)
    end

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

function AggressionSystem:beginContact(a, b, contact)
  if collision.is('player', a) and collision.isAggression(b) then
    startAttack(b, a)
  elseif collision.isAggression(a) and collision.is('player', b) then
    startAttack(a, b)
  end
end

function AggressionSystem:endContact(a, b, contact)
  if collision.is('player', a) and collision.isAggression(b) then
    stopAttack(b)
  elseif collision.isAggression(a) and collision.is('player', b) then
    stopAttack(a)
  end
end

return AggressionSystem
