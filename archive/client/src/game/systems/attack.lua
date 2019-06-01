local Aspect = require 'src.ecs.aspect'
local System = require 'src.ecs.system'
local Ability = require 'src.game.components.ability'
local Aggression = require 'src.game.components.aggression'
local Attack = require 'src.game.components.attack'
local Fixture = require 'src.game.components.fixture'
local Movement = require 'src.game.components.movement'
local Position = require 'src.game.components.position'

local aspect = Aspect.new({Ability, Attack, Fixture, Movement, Position})
local AttackSystem = System:new('aggression', aspect)

local function targetDistance(entity)
  local ability = entity:as(Ability)
  local attack = entity:as(Attack)
  local movement = entity:as(Movement)
  local x1, y1 = entity:as(Position):coords()
  local x2, y2 = attack.target:as(Position):coords()

  return x2 - x1, y2 - y1
end

local function track(entity, distance, speed)
  local ability = entity:as(Ability)
  local fixture = entity:as(Fixture)
  local body = fixture.fixture:getBody()
  local velocityX, velocityY = body:getLinearVelocity()
  local dx, dy = targetDistance(entity)
  local newVelocityX = math.sign(dx) * (speed or 100)

  if math.abs(dx) < distance then
    newVelocityX = 0
  end

  body:setLinearVelocity(newVelocityX, velocityY)
end

function AttackSystem:onRemove(entity)
  entity:as(Ability):reset()
end

function AttackSystem:shoot(dt, entity)
  local dx, dy = targetDistance(entity)

  if dx <= 0 then
    movement.direction = 'left'
  else
    movement.direction = 'right'
  end

  ability:setActivated('shoot', true)
end

function AttackSystem:slash(dt, entity)
  track(entity, 50)
end

function AttackSystem:stab(dt, entity)
  track(entity, 50)
end

function AttackSystem:taser(dt, entity)
  track(entity, entity:as(Aggression).width / 2)
end

function AttackSystem:update(dt)
  for _, entity in pairs(self.entities) do
    local abilities = entity:as(Ability).abilities

    if abilities.slash.enabled then
      self:slash(dt, entity)
    elseif abilities.shoot.enabled then
      self:shoot(dt, entity)
    elseif abilities.stab.enabled then
      self:stab(dt, entity)
    elseif abilities.taser.enabled then
      self:taser(dt, entity)
    end
  end
end

return AttackSystem
