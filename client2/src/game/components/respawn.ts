import { Component } from '../../ecs/Component'
import { Flag } from './flags'

export class Respawn extends Component {
  static _id = 'Respawn'
  _id = Respawn._id

  static _flag = Flag.Respawn
  _flag = Flag.Respawn

  waitTime: number

  constructor(waitTime: number = 0) {
    super()

    this.waitTime = waitTime
  }
}
