local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Projectile = require 'game.components.projectile'

local aspect = Aspect:new({Projectile, Position, Velocity})
local ProjectileSystem = System:new('projectile', aspect)

function ProjectileSystem:update(dt)
  -- print('projectile update ', table.getn(self.entities))
end

return ProjectileSystem
