local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Projectile = require 'game.components.projectile'

local aspect = Aspect:new({Projectile})
local ProjectileSystem = System:new('projectile', aspect)

local function isProjectile(fixture)
  return fixture:getUserData().entity:getAs(Data) == 'throwingPick'
end

local function isProjectile(fixture)
  return fixture:getUserData().entity:has(Projectile)
end

function ProjectileSystem:collision(a, b, contact)
end

return ProjectileSystem
