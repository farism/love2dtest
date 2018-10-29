local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Dig = require 'game.components.dig'
local Fixture = require 'game.components.fixture'
local Movement = require 'game.components.movement'

local aspect = Aspect:new({Dig})
local DigSystem = System:new('dig', aspect)

function DigSystem:update(dt)
  for _, entity in pairs(self.entities) do
    local dig = entity:as(Dig)

    dig.duration = dig.duration - dt

    if (dig.duration <= 0) then
      self.manager:removeComponent(entity, dig)
    end
  end
end

return DigSystem
