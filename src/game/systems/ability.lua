local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Ability = require 'game.components.ability'
local Fixture = require 'game.components.fixture'
local Movement = require 'game.components.movement'
local Position = require 'game.components.position'
local Projectile = require 'game.components.projectile'
local Timer = require 'game.components.timer'

local aspect = Aspect:new({Ability, Movement, Position, Timer})
local AbilitySystem = System:new('ability', aspect)

function AbilitySystem:throw(dt, entity)
  local manager = entity.manager
  local factory = manager.factory
  local position = entity:as(Position)
  local movement = entity:as(Movement)
  local projectile = factory.create(factory.throwingPick())
  local body = projectile:as(Fixture).fixture:getBody()
  body:setFixedRotation(false)
  body:setGravityScale(0)
  body:setX(position.x + 10)
  body:setY(position.y)
  if (movement.direction == 'left') then
    body:setLinearVelocity(-1000, 0)
  elseif movement.direction == 'right' then
    body:setLinearVelocity(1000, 0)
  end
end

function AbilitySystem:dash(dt, entity)
  local ability = entity:as(Ability)
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

function AbilitySystem:grapple(dt, entity)
end

function AbilitySystem:dig(dt, entity)
end

function AbilitySystem:update(dt)
  for _, entity in pairs(self.entities) do
    local timer = entity:as(Timer)
    local abilities = entity:as(Ability).abilities

    for key, ability in pairs(abilities) do
      local timers = timer.timers[key] or {}
      timer.timers[key] = timers

      if ability.active and (timer.timers[key].cooldown or 0) == 0 then
        ability.active = false
        timer.timers[key].cooldown = ability.cooldown
        timer.timers[key].duration = ability.duration
        self[key](self, dt, entity)
      elseif (timer.timers[key].duration or 0) > 0 then
        self[key](self, dt, entity)
      end
    end
  end
end

return AbilitySystem
