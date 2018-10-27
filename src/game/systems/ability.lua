local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Ability = require 'game.components.ability'
local Cooldown = require 'game.components.cooldown'
local Dash = require 'game.components.dash'
local Fixture = require 'game.components.fixture'
local Movement = require 'game.components.movement'
local Position = require 'game.components.position'

local aspect = Aspect:new({Ability, Cooldown, Movement, Position})
local AbilitySystem = System:new('ability', aspect)

local abilities = {
  throw = {
    cooldown = 1,
    update = 'throw'
  },
  dash = {
    cooldown = 1,
    update = 'dash'
  },
  grapple = {
    cooldown = 1,
    update = 'grapple'
  },
  dig = {
    cooldown = 1,
    update = 'dig'
  }
}

function AbilitySystem:throw(dt, entity)
  local manager = entity.manager
  local factory = manager.factory
  local position = entity:as(Position)
  local projectile = manager:newEntity()
  factory.add(projectile, factory.throwingPick)
  local fixture = projectile:as(Fixture)
  local body = fixture.fixture:getBody()
  body:setFixedRotation(false)
  body:setGravityScale(0)
  body:setX(position.x + 10)
  body:setY(position.y)
  body:setLinearVelocity(1000, 0)
end

function AbilitySystem:dash(dt, entity)
  self.manager:addComponent(entity, Dash.new(1))
end

function AbilitySystem:grapple(dt, entity)
end

function AbilitySystem:dig(dt, entity)
end

function AbilitySystem:update(dt)
  for _, entity in pairs(self.entities) do
    local ability = entity:as(Ability)
    local cooldown = entity:as(Cooldown)

    for key, value in pairs(abilities) do
      if ability[key] and cooldown.timers[key] == 0 then
        ability[key] = false
        self[value.update](self, dt, entity)
        cooldown.timers[key] = value.cooldown
      end
    end
  end
end

return AbilitySystem
