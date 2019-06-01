import { WINDOW_HEIGHT } from '../../conf'
import { System } from '../../ecs/System'
import { Aspect } from '../../ecs/Aspect'
import { SystemFlag } from '../flags'
import { GameObject } from '../components/GameObject'
import { Health } from '../components/Health'
import { Player } from '../components/Player'
import { Position } from '../components/Position'

const BUFFER = 100

export class FallDeathSystem extends System {
  static _id = 'FallDeath'
  _id = FallDeathSystem._id

  static _flag = SystemFlag.FallDeath
  _flag = FallDeathSystem._flag

  static _aspect = new Aspect([GameObject, Health, Player, Position])
  _aspect = FallDeathSystem._aspect

  update = (dt: number) => {
    this.entities.forEach(entity => {
      const position = entity.as(Position)

      if (position && position.y > WINDOW_HEIGHT + BUFFER) {
        const health = entity.as(Health)

        if (health) {
          health.hitpoints = 0
        }
      }
    })
  }
}
