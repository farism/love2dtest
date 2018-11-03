local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Projectile = require 'game.components.projectile'

local ProjectileSystem = System:new('damage', Aspect.never())

function ProjectileSystem:collision(a, b, contact)
  local ae = a:getUserData().entity
  local be = b:getUserData().entity

  if ae:has(Projectile) and not b:isSensor() then
    ae:destroy()
  elseif be:has(Projectile) and not a:isSensor() then
    be:destroy()
  end
end

return ProjectileSystem
