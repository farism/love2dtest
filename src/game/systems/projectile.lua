local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Projectile = require 'game.components.projectile'

local aspect = Aspect:new({Projectile})
local ProjectileSystem = System:new('projectile', aspect)

function ProjectileSystem:collision(a, b, contact)
  print(a:getUserData())
  print(b:getUserData())
end

return ProjectileSystem
