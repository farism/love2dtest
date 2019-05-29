import { Aspect } from '../../ecs/Aspect'
import { Entity } from '../../ecs/Entity'
import { System } from '../../ecs/System'
import { Abilities, AbilityType } from '../components/Abilities'
import { Attack } from '../components/Attack'
import { GameObject } from '../components/GameObject'
import { Movement } from '../components/Movement'
import { Position } from '../components/Position'
import { SystemFlag } from '../flags'
import { sign } from '../utils/math'

const getDistanceToTarget = (entity: Entity): number => {
  const attack = entity.as(Attack)
  const pos1 = entity.as(Position)

  if (attack && pos1) {
    const pos2 = attack.target.as(Position)

    if (pos2) {
      return pos2.x - pos1.x
    }
  }

  return 0
}

const follow = (
  followDistance: number,
  followVelocity: number,
  entity: Entity
) => {
  const gameObject = entity.as(GameObject)
  const movement = entity.as(Movement)

  if (!gameObject || !movement) {
    return false
  }

  const x = getDistanceToTarget(entity)

  const body = gameObject.fixture.getBody()

  const [velocityX, velocityY] = body.getLinearVelocity()

  let newVelocityX = sign(x) * followVelocity

  if (Math.abs(x) < followDistance) {
    newVelocityX = 0
  }

  if (newVelocityX < 0) {
    movement.direction = 'left'
  } else {
    movement.direction = 'right'
  }

  body.setLinearVelocity(newVelocityX, velocityY)
}

export class AttackSystem extends System {
  static _id = 'Attack'
  _id = AttackSystem._id

  static _flag = SystemFlag.Attack
  _flag = AttackSystem._flag

  static _aspect = new Aspect([Attack, GameObject, Movement, Position])
  _aspect = AttackSystem._aspect

  update = (dt: number) => {
    this.entities.forEach(entity => {
      const attack = entity.as(Attack)
      const gameObject = entity.as(GameObject)

      if (!attack || !gameObject) {
        return
      }

      const dx = getDistanceToTarget(entity)

      if (Math.abs(dx) < attack.followDistance) {
        const abilities = entity.as(Abilities)

        if (abilities) {
          for (let key in abilities.abilities) {
            abilities.setActivated(key as AbilityType, true)
          }
        }
      } else {
        follow(attack.followDistance, attack.followVelocity, entity)
      }
    })
  }

  onRemove = (entity: Entity) => {
    const abilities = entity.as(Abilities)

    abilities && abilities.reset()
  }
}
