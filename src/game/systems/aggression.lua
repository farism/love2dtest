local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Attack = require 'game.components.attack'
local Aggression = require 'game.components.aggression'
local Fixture = require 'game.components.fixture'
local Position = require 'game.components.position'
local Timer = require 'game.components.timer'
local collision = require 'game.utils.collision'

local aspect = Aspect:new({Aggression, Fixture, Position, Timer})
local AggressionSystem = System:new('aggression', aspect)

local STOP_ATTACK_DURATION = 3

function startAttack(origin, target)
  collision.entity(origin):add(Attack.new(1, collision.entity(target)))
end

function stopAttack(origin)
  local timer = collision.entity(origin):as(Timer)
  timer.timers.stopAttack = {duration = STOP_ATTACK_DURATION}
end

function AggressionSystem:update(dt)
  for _, entity in pairs(self.entities) do
    local aggression = entity:as(Aggression)
    local fixture = entity:as(Fixture)
    local timer = entity:as(Timer)

    if timer.timers.stopAttack and timer.timers.stopAttack.duration == 0 then
      timer.timers.stopAttack = nil
      entity:remove(Attack)
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
    stopAttack(b, a)
  elseif collision.isAggression(a) and collision.is('player', b) then
    stopAttack(a, b)
  end
end

return AggressionSystem
