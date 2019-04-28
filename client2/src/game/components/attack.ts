import { Entity } from '../../ecs/Entity'
import { ComponentFlag } from '../flags'

export class Attack {
  static _id = 'Attack'
  _id = Attack._id

  static _flag = ComponentFlag.Attack
  _flag = ComponentFlag.Attack

  target: Entity

  constructor(target: Entity) {
    this.target = target
  }
}
