import { System } from '../../ecs/System'
import { SystemFlag } from '../flags'
import { NeverAspect } from '../../ecs/Aspect'
import { check, hasComponent } from '../utils/collision'
import { Player } from '../components/Player'
import { Snare } from '../components/Snare'

export class SnareSystem extends System {
  static _id = 'Snare'
  _id = SnareSystem._id

  static _flag = SystemFlag.Snare
  _flag = SnareSystem._flag

  static _aspect = new NeverAspect()
  _aspect = SnareSystem._aspect

  beginContact = (a: Fixture, b: Fixture, contact: Contact) => {
    const result = check(a, b, [hasComponent(Player), hasComponent(Snare)])

    if (!result) {
      return
    }
  }
}
