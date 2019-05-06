import { System } from '../../ecs/System'
import { SystemFlag } from '../flags'
import { Aspect } from '../../ecs/Aspect'
import { Health } from '../components/Health'
import { Respawn } from '../components/Respawn'
import { Player } from '../components/Player'
import { Blueprint } from '../utils/factory'
import { Entity } from '../../ecs/Entity'

const deathFunctions: { [key: string]: (entity: Entity) => void } = {
  [Blueprint.Player]: (entity: Entity) => {
    const health = entity.as(Health)
    const player = entity.as(Player)

    if (!player || !health) {
      return
    }

    player.lives--

    entity.add(new Respawn(3))
  },
}

export class DeathSystem extends System {
  static _id = 'DeathSystem'
  _id = DeathSystem._id

  static _flag = SystemFlag.Death
  _flag = DeathSystem._flag

  static _aspect = new Aspect([Health])
  _aspect = DeathSystem._aspect

  update = (dt: number) => {
    this.entities.forEach(entity => {
      const health = entity.as(Health)

      if (!health) {
        return
      }

      if (health.hitpoints <= 0 && entity.userData.blueprint) {
        const fn = deathFunctions[entity.userData.blueprint]

        fn && fn(entity)
      }
    })
  }
}
