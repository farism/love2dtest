import { Aspect } from '../../ecs/Aspect'
import { Entity } from '../../ecs/Entity'
import { System } from '../../ecs/System'
import { Abilities } from '../components/Abilities'
import { Attack } from '../components/Attack'
import { GameObject } from '../components/GameObject'
import { Movement } from '../components/Movement'
import { Position } from '../components/Position'
import { Point } from '../components/Waypoint'
import { SystemFlag } from '../flags'
import { sign } from '../utils/math'

const targetDistance = (entity: Entity): Point => {
  const attack = entity.as(Attack)
  const pos1 = entity.as(Position)

  if (attack && pos1) {
    const pos2 = attack.target.as(Position)

    if (pos2) {
      return {
        x: pos2.x - pos1.x,
        y: pos2.y - pos1.y,
      }
    }
  }

  return {
    x: 0,
    y: 0,
  }
}

const track = (maxDistance: number, velocity: number, entity: Entity) => {
  const gameObject = entity.as(GameObject)

  if (!gameObject) {
    return
  }

  const body = gameObject.fixture.getBody()
  const [velocityX, velocityY] = body.getLinearVelocity()
  const delta = targetDistance(entity)
  const x = delta.x || 0

  let newVelocityX = sign(x) * velocity

  if (Math.abs(x) < maxDistance) {
    newVelocityX = 0
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
      track(50, 100, entity)
    })
  }

  onRemove = (entity: Entity) => {
    const abilities = entity.as(Abilities)

    abilities && abilities.reset()
  }
}
