import { System } from '../../ecs/System'
import { SystemFlag } from '../flags'
import { check, hasComponent, isSensor } from '../utils/collision'
import { Projectile } from '../components/Projectile'
import { Aspect } from '../../ecs/Aspect'

export class ProjectileSystem extends System {
  static _id = 'ProjectileSystem'
  _id = ProjectileSystem._id

  static _flag = SystemFlag.ProjectileSystem
  _flag = ProjectileSystem._flag

  static _aspect = new Aspect([Projectile])
  _aspect = ProjectileSystem._aspect

  beginContact = (a: Fixture, b: Fixture, c: Contact) => {
    const result = check(a, b, [hasComponent(Projectile), isSensor])

    if (result) {
      result[0].destroy()
    }
  }
}
