import { System } from '../../ecs/System'
import { SystemFlag } from '../flags'
import { Aspect } from '../../ecs/Aspect'
import { check, hasComponent } from '../utils/collision'
import { Trigger } from '../components/Trigger'
import { Player } from '../components/Player'

export class TriggerSystem extends System {
  static _id = 'Trigger'
  _id = TriggerSystem._id

  static _flag = SystemFlag.Trigger
  _flag = TriggerSystem._flag

  static _aspect = new Aspect([Trigger])
  _aspect = TriggerSystem._aspect

  update = (dt: number) => {
    this.entities.forEach(entity => {
      const trigger = entity.as(Trigger)

      if (trigger && trigger.activated && !trigger.executed) {
        trigger.action()
        trigger.executed = true
      }
    })
  }

  beginContact = (a: Fixture, b: Fixture, contact: Contact) => {
    const result = check(a, b, [hasComponent(Trigger), hasComponent(Player)])

    if (!result) {
      return
    }

    const trigger = result[0].as(Trigger)

    if (trigger) {
      trigger.activated = true
    }
  }
}
