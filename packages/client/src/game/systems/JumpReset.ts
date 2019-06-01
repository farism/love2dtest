import { System } from '../../ecs/System'
import { SystemFlag } from '../flags'
import { NeverAspect } from '../../ecs/Aspect'
import { Movement } from '../components/Movement'
import { check, hasComponent, isNotBodyType } from '../utils/collision'
import { Player } from '../components/Player'

export class JumpResetSystem extends System {
  static _id = 'JumpReset'
  _id = JumpResetSystem._id

  static _flag = SystemFlag.JumpReset
  _flag = JumpResetSystem._flag

  static _aspect = new NeverAspect()
  _aspect = JumpResetSystem._aspect

  beginContact = (a: Fixture, b: Fixture, contact: Contact) => {
    const result = check(a, b, [hasComponent(Player), isNotBodyType('dynamic')])

    if (!result) {
      return
    }

    const [player] = result
    const [nx, ny] = contact.getNormal()

    if (nx == -1 || nx == 1 || ny < 0) {
      const movement = player.as(Movement)

      if (movement) {
        movement.jumpCount = 0
      }
    }
  }
}
