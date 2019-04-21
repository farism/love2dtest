import { Component } from '../../ecs/Component'
import { Flag } from './flags'

export class Checkpoint extends Component {
  static _id = 'Checkpoint'
  _id = Checkpoint._id

  static _flag = Flag.Checkpoint
  _flag = Flag.Checkpoint

  hitpoints: number

  constructor(hitpoints: number = 0) {
    super()

    this.hitpoints = hitpoints
  }
}
