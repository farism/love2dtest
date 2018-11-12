local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Ability = require 'game.components.ability'
local Dash = require 'game.components.dash'
local Fixture = require 'game.components.fixture'

local aspect = Aspect:new({Ability, Dash, Fixture})
local DashSystem = System:new('dash', aspect)

function DashSystem:update(dt)
  for _, entity in pairs(self.entities) do
    local animation = entity:as(Dash)
    local fixture = entity:as(Fixture)
  end
end

return DashSystem
