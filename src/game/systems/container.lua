local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Container = require 'game.components.container'

local aspect = Aspect:new({Container})
local ContainerSystem = System:new('container', aspect)

function ContainerSystem:update(dt)
end

return ContainerSystem
