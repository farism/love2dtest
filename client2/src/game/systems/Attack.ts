import { Aspect } from '../../ecs/Aspect'
import { System } from '../../ecs/System'
import { SystemFlag } from '../flags'
import { GameObject } from '../components/GameObject'
import { Position } from '../components/Position'
import { Attack } from '../components/Attack'
import { Movement } from '../components/Movement'
import { Abilities } from '../components/Abilities'
import { Entity } from '../../ecs/Entity'
import { Point } from '../components/Waypoint'
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

const track = (distance: number, speed: number, entity: Entity) => {
  const gameObject = entity.as(GameObject)

  if (!gameObject) {
    return
  }

  const body = gameObject.fixture.getBody()
  const [velocityX, velocityY] = body.getLinearVelocity()
  const delta = targetDistance(entity)

  let newVelocityX = sign(delta.x) * (speed || 100)

  if (Math.abs(delta.x) < distance) {
    newVelocityX = 0
  }

  body.setLinearVelocity(newVelocityX, velocityY)
}

export class AttackSystem extends System {
  static _id = 'Attack'
  _id = AttackSystem._id

  static _flag = SystemFlag.Attack
  _flag = AttackSystem._flag

  static _aspect = new Aspect([
    Abilities,
    Attack,
    GameObject,
    Movement,
    Position,
  ])
  _aspect = AttackSystem._aspect

  update = (dt: number) => {
    this.entities.forEach(entity => {})
  }

  onRemove = (entity: Entity) => {
    const abilities = entity.as(Abilities)

    abilities && abilities.reset()
  }
}
