local Aspect = require 'src.ecs.aspect'
local System = require 'src.ecs.system'
local Container = require 'src.game.components.container'

local aspect = Aspect.new({Container})
local ContainerSystem = System:new('container', aspect)

function ContainerSystem:update(dt)
  for _, entity in pairs(self.entities) do
  end
end

return ContainerSystem
