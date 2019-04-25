// local Aspect = require 'src.ecs.aspect'
// local System = require 'src.ecs.system'
// local Projectile = require 'src.game.components.projectile'

// local ProjectileSystem = System:new('damage', Aspect.never())

// function ProjectileSystem:beginContact(a, b, contact)
//   local ae = a:getUserData().entity
//   local be = b:getUserData().entity

//   if ae:has(Projectile) and not b:isSensor() then
//     ae:destroy()
//   elseif be:has(Projectile) and not a:isSensor() then
//     be:destroy()
//   end
// end

// return ProjectileSystem
