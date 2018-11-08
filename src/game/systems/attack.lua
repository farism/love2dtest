local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Ability = require 'game.components.ability'
local Attack = require 'game.components.attack'
local Position = require 'game.components.position'

local aspect = Aspect:new({Ability, Attack, Position})
local AttackSystem = System:new('aggression', aspect)

function AttackSystem:update(dt)
  for _, entity in pairs(self.entities) do
    local ability = entity:as(Ability)
    local target = entity:as(Attack).target
    ability.abilities.throw.active = true
  end
end

return AttackSystem
