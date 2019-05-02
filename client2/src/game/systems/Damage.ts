import { System } from '../../ecs/System'
import { SystemFlag } from '../flags'
import { NeverAspect } from '../../ecs/Aspect'
import { check, hasComponent, isNotBodyType } from '../utils/collision'
import { Damage } from '../components/Damage'
import { Health } from '../components/Health'

export class DamageSystem extends System {
  static _id = 'Damage'
  _id = DamageSystem._id

  static _flag = SystemFlag.Damage
  _flag = DamageSystem._flag

  static _aspect = new NeverAspect()
  _aspect = DamageSystem._aspect

  beginContact = (a: Fixture, b: Fixture, contact: Contact) => {
    const result = check(a, b, [hasComponent(Damage), hasComponent(Health)])

    if (!result) {
      return
    }

    const damage = result[0].as(Damage)
    const health = result[0].as(Health)
    if (damage && health) {
      health.hitpoints = health.armor - damage.hitpoints
    }
  }
}
