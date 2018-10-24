local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Projectile = require 'game.components.projectile'

local aspect = Aspect:new({Projectile})
local ProjectileSystem = System:new('projectile', aspect)

function ProjectileSystem:update(dt)
  -- print('projectile update ', table.getn(entities))
end

return ProjectileSystem
