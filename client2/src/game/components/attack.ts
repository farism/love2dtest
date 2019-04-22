import { Component } from '../../ecs/Component'
import { Entity } from '../../ecs/Entity'
import { Flag } from './flags'

export class Attack {
  static _id = 'Attack'
  _id = Attack._id

  static _flag = Flag.Attack
  _flag = Flag.Attack

  target: Entity

  constructor(target: Entity) {
    this.target = target
  }
}
