import { System } from '../../ecs/System'
import { SystemFlag } from '../flags'
import { NeverAspect } from '../../ecs/Aspect'
import { hasComponent, check } from '../utils/collision'
import { Player } from '../components/Player'
import { Checkpoint } from '../components/Checkpoint'

export class CheckpointSystem extends System {
  static _id = 'Checkpoint'
  _id = CheckpointSystem._id

  static _flag = SystemFlag.Checkpoint
  _flag = CheckpointSystem._flag

  static _aspect = new NeverAspect()
  _aspect = CheckpointSystem._aspect

  beginContact = (a: Fixture, b: Fixture, contact: Contact) => {
    const result = check(a, b, [hasComponent(Player), hasComponent(Checkpoint)])

    if (result) {
      const player = result[0].as(Player)
      const checkpoint = result[1].as(Checkpoint)

      if (player && checkpoint) {
        checkpoint.visited = true
        player.checkpoint = Math.max(checkpoint.index)
      }
    }
  }
}
