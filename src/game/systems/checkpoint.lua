local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Checkpoint = require 'game.components.input'

local aspect = Aspect:new({Checkpoint})
local CheckpointSystem = System:new('checkpoint', aspect)

function CheckpointSystem:update(dt)
  for _, entity in pairs(self.entities) do
  end
end

return CheckpointSystem
