import { Aspect } from '../../ecs/Aspect'
import { Entity } from '../../ecs/Entity'
import { System } from '../../ecs/System'
import { Abilities, AbilityType } from '../components/Abilities'
import { Attack } from '../components/Attack'
import { GameObject } from '../components/GameObject'
import { Movement } from '../components/Movement'
import { Position } from '../components/Position'
import { SystemFlag } from '../flags'
import * as math from '../utils/math'

const getDistanceToTarget = (target: Entity, entity: Entity): number => {
  const targetPosition = target.as(Position)
  const entityPosition = entity.as(Position)

  if (targetPosition && entityPosition) {
    return targetPosition.x - entityPosition.x
  }

  return 0
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
      const movement = entity.as(Movement)

      if (!attack || !gameObject || !movement) {
        return
      }

      const dx = getDistanceToTarget(attack.target, entity)

      if (Math.abs(dx) < attack.followDistance) {
        // in range, activate abilities
        const abilities = entity.as(Abilities)

        if (abilities) {
          for (let key in abilities.abilities) {
            const ability = abilities.abilities[key as AbilityType]

            if (ability) {
              ability.activated = true
            }
          }
        }
      } else {
        // not in range, follow target
        const body = gameObject.fixture.getBody()

        let [velocityX, velocityY] = body.getLinearVelocity()

        velocityX = 0

        if (Math.abs(dx) > attack.followDistance) {
          velocityX = math.sign(dx) * attack.followVelocity
        }

        body.setLinearVelocity(velocityX, velocityY)
      }

      // make sure attacker is facing the target
      if (dx < 0) {
        movement.direction = 'left'
      } else if (dx > 0) {
        movement.direction = 'right'
      }
    })
  }

  onRemove = (entity: Entity) => {
    const abilities = entity.as(Abilities)

    abilities && abilities.reset()
  }
}
