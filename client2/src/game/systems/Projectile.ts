// local Aspect = require 'src.ecs.aspect'
// local System = require 'src.ecs.system'
// local Projectile = require 'src.game.components.projectile'

// local Projectile = System:new('damage', Aspect.never())

// function Projectile:beginContact(a, b, contact)
//   local ae = a:getUserData().entity
//   local be = b:getUserData().entity

//   if ae:has(Projectile) and not b:isSensor() then
//     ae:destroy()
//   elseif be:has(Projectile) and not a:isSensor() then
//     be:destroy()
//   end
// end

// return Projectile

import { System } from '../../ecs/System'
import { SystemFlag } from '../flags'

export class Projectile extends System {
  static _id = 'Projectile'
  _id = Projectile._id

  static _flag = SystemFlag.Projectile
  _flag = Projectile._flag

  beginContact = (a: Fixture, b: Fixture, c: Contact) => {}
}
