local cron = require 'src.vendor.cron'
local Aspect = require 'src.ecs.aspect'
local System = require 'src.ecs.system'
local collision = require 'src.game.utils.collision'
local Ability = require 'src.game.components.ability'
local Damage = require 'src.game.components.damage'
local Dash = require 'src.game.components.dash'
local Fixture = require 'src.game.components.fixture'
local Movement = require 'src.game.components.movement'
local Player = require 'src.game.components.player'
local Position = require 'src.game.components.position'
local Projectile = require 'src.game.components.projectile'
local Respawn = require 'src.game.components.respawn'

local aspect = Aspect.new({Ability}, {Respawn})
local AbilitySystem = System:new('ability', aspect)

function AbilitySystem:throw(entity)
  local factory = entity.manager.factory
  local position = entity:as(Position)
  local movement = entity:as(Movement)
  local x, y = position:coords()
  local projectile = factory.create(factory.throwingPick(entity, x, y))
  local fixture = projectile:as(Fixture)
  local body = fixture.fixture:getBody()

  if (movement.direction == 'left') then
    body:setLinearVelocity(-1500, 0)
  else
    body:setLinearVelocity(1500, 0)
  end
end

function AbilitySystem:dashStart(entity)
  local fixture = entity:as(Fixture)
  fixture.fixture:setCategory(3)

  entity:add(Dash.new(1))
  entity:add(Damage.new(1, 1))
end

function AbilitySystem:dashEnd(entity)
  local fixture = entity:as(Fixture)
  fixture.fixture:setCategory(2)

  entity:remove(Dash)
  entity:remove(Damage)
end

function AbilitySystem:grapple(entity)
end

function AbilitySystem:dig(entity)
end

function AbilitySystem:shoot(entity)
  local factory = entity.manager.factory
  local position = entity:as(Position)
  local movement = entity:as(Movement)
  local x, y = position:coords()
  local projectile = factory.create(factory.throwingPick(entity, x, y))
  local fixture = projectile:as(Fixture)
  local body = fixture.fixture:getBody()

  if (movement.direction == 'left') then
    body:setLinearVelocity(-2000, 0)
  else
    body:setLinearVelocity(2000, 0)
  end
end

function AbilitySystem:slash(entity)
end

function AbilitySystem:stab(entity)
end

function AbilitySystem:taser(entity)
end

function AbilitySystem:update(dt)
  for _, entity in pairs(self.entities) do
    local abilities = entity:as(Ability).abilities

    for key, ability in pairs(abilities) do
      local timers = ability.timers

      if timers.cooldown then
        timers.cooldown:update(dt)
      end

      if timers.duration then
        timers.duration:update(dt)
      end

      if timers.casting then
        timers.casting:update(dt)
      end

      local cooldown = function()
        timers.cooldown = nil
      end

      local casting = function()
        timers.casting = nil
        self[key](self, entity)
      end

      local duration = function()
        timers.duration = nil
        self[key .. 'End'](self, entity)
      end

      if ability.activated and not timers.cooldown then
        ability.activated = false

        timers.cooldown = cron.after(ability.cooldown, cooldown)

        if (ability.castspeed or 0) > 0 and not timers.casting then
          timers.casting = cron.after(ability.castspeed, casting)
        elseif (ability.duration or 0) > 0 and not timers.duration then
          self[key .. 'Start'](self, entity)
          timers.duration = cron.after(ability.duration, duration)
        else
          self[key](self, entity)
        end
      end
    end
  end
end

return AbilitySystem
