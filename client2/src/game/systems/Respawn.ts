import { System } from '../../ecs/System'
import { Manager } from '../../ecs/manager'
import { SystemFlag } from '../flags'
import { Aspect } from '../../ecs/Aspect'
import { Player } from '../components/Player'
import { Respawn } from '../components/Respawn'
import { Checkpoint } from '../components/Checkpoint'
import { setTimeout } from '../utils/timer'
import { Entity } from '../../ecs/Entity'
import { GameObject } from '../components/GameObject'
import { Position } from '../components/Position'

const findCheckpoint = (
  index: number,
  manager: Manager
): Entity | undefined => {
  let entity

  manager.entities.forEach(entity => {
    const checkpoint = entity.as(Checkpoint)

    if (checkpoint && checkpoint.index === index) {
      entity = entity
    }
  })

  return entity
}

const resetPosition = (entity: Entity) => {
  const player = entity.as(Player)

  if (!player) {
    return
  }

  const checkpoint = findCheckpoint(
    player.checkpoint,
    entity.manager as Manager
  )

  if (!checkpoint) {
    return
  }

  const gameObject = entity.as(GameObject)
  const position = checkpoint.as(Position)

  if (!position || !gameObject) {
    return
  }

  const body = gameObject.fixture.getBody()
  body.setType('static')
  body.setPosition(position.x, position.y)
  body.setType('dynamic')

  entity.remove(Respawn)
}

export class RespawnSystem extends System {
  static _id = 'Respawn'
  _id = RespawnSystem._id

  static _flag = SystemFlag.Respawn
  _flag = RespawnSystem._flag

  static _aspect = new Aspect([Respawn])
  _aspect = RespawnSystem._aspect

  update = (dt: number) => {
    this.entities.forEach(entity => {
      const player = entity.as(Player)
      const respawn = entity.as(Respawn)

      if (!player || !respawn) {
        return
      }

      respawn.timer = setTimeout(respawn.duration, () => {
        resetPosition(entity)
      })
    })
  }
}
