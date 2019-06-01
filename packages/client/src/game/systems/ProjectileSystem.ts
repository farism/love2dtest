import { Aspect } from '../../ecs/Aspect'
import { System } from '../../ecs/System'
import { GameObject } from '../components/GameObject'
import { Projectile } from '../components/Projectile'
import { SystemFlag } from '../flags'
import { check, hasComponent } from '../utils/collision'

export class ProjectileSystem extends System {
  static _id = 'ProjectileSystem'
  _id = ProjectileSystem._id

  static _flag = SystemFlag.ProjectileSystem
  _flag = ProjectileSystem._flag

  static _aspect = new Aspect([Projectile])
  _aspect = ProjectileSystem._aspect

  beginContact = (a: Fixture, b: Fixture, c: Contact) => {
    const result = check(a, b, [
      hasComponent(Projectile),
      hasComponent(GameObject),
    ])

    if (result && result[0] && result[1]) {
      const [projectile] = result

      projectile && projectile.destroy()
    }
  }
}
