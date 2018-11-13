local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Fixture = require 'game.components.fixture'

local aspect = Aspect.new({Fixture})
local PlatformMovement = System:new('platformmovement', aspect)

function PlatformMovement:update(dt)
  for _, entity in pairs(self.entities) do
  end
end

return PlatformMovement
