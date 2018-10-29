local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'

local DeathSystem = System:new('death')

function DeathSystem:collision(a, b, contact)
  -- print(a.entity)
end

return DeathSystem
