local Aspect = require 'src.ecs.aspect'
local System = require 'src.ecs.system'
local Damage = require 'src.game.components.damage'
local Fixture = require 'src.game.components.fixture'
local Health = require 'src.game.components.health'

local DamageSystem = System:new('damage', Aspect.always())

function DamageSystem:beginContact(a, b, contact)
  a = a:getUserData().entity
  b = b:getUserData().entity
  local health
  local damage

  if a:has(Damage) and b:has(Health) then
    damage = a:as(Damage)
    health = b:as(Health)
  elseif a:has(Health) and b:has(Damage) then
    health = a:as(Health)
    damage = b:as(Damage)
  end

  if health and damage then
    health.hitpoints = health.hitpoints - damage.hitpoints
  end
end

return DamageSystem
