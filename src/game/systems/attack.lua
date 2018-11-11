local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Ability = require 'game.components.ability'
local Attack = require 'game.components.attack'
local Fixture = require 'game.components.fixture'
local Position = require 'game.components.position'

local aspect = Aspect:new({Ability, Attack, Fixture, Position})
local AttackSystem = System:new('aggression', aspect)

function AttackSystem:update(dt)
  for _, entity in pairs(self.entities) do
    local attack = entity:as(Attack)
    local ability = entity:as(Ability)
    local fixture = entity:as(Fixture)
    local position = entity:as(Position)
    local position2 = attack.target:as(Position)
    local distance = position2.x - position.x
    local body = fixture.fixture:getBody()
    local velocityX, velocityY = body:getLinearVelocity()
    local newVelocityX = math.sign(distance) * 50

    body:setLinearVelocity(newVelocityX, velocityY)
  end
end

return AttackSystem
