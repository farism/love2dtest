import { Component } from '../../ecs/Component'
import { Flag } from './flags'

export class Health extends Component {
  static _id = 'Health'
  _id = Health._id

  static _flag = Flag.Health
  _flag = Flag.Health

  hitpoints: number
  armor: number

  constructor(hitpoints: number = 0, armor: number = 0) {
    super()

    this.hitpoints = hitpoints
    this.armor = armor
  }
}
