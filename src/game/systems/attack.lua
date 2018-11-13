local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Ability = require 'game.components.ability'
local Attack = require 'game.components.attack'
local Fixture = require 'game.components.fixture'
local Movement = require 'game.components.movement'
local Position = require 'game.components.position'

local aspect = Aspect.new({Ability, Attack, Fixture, Movement, Position})
local AttackSystem = System:new('aggression', aspect)

function AttackSystem:onRemove(entity)
  entity:as(Ability):reset()
end

function AttackSystem:shoot(dt, entity)
  local ability = entity:as(Ability)
  local attack = entity:as(Attack)
  local movement = entity:as(Movement)
  local x1, y2 = entity:as(Position):coords()
  local x2, y2 = attack.target:as(Position):coords()

  if x2 <= x1 then
    movement.direction = 'left'
  else
    movement.direction = 'right'
  end

  ability:setActivated('shoot', true)
end

function AttackSystem:slash(dt, entity)
  local ability = entity:as(Ability)
  local attack = entity:as(Attack)
  local fixture = entity:as(Fixture)
  local position = entity:as(Position)
  local position2 = attack.target:as(Position)
  local distance = position2.x - position.x
  local body = fixture.fixture:getBody()
  local velocityX, velocityY = body:getLinearVelocity()
  local newVelocityX = math.sign(distance) * 100

  if math.abs(distance) < 50 then
    newVelocityX = 0
    ability:setActivated('slash', true)
  end

  body:setLinearVelocity(newVelocityX, velocityY)
end

function AttackSystem:update(dt)
  for _, entity in pairs(self.entities) do
    local abilities = entity:as(Ability).abilities

    if abilities.slash.enabled then
      self:slash(dt, entity)
    elseif abilities.shoot.enabled then
      self:shoot(dt, entity)
    end
  end
end

return AttackSystem
