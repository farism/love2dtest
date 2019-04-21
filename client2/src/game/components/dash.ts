import { Component } from '../../ecs/Component'
import { Flag } from './flags'

export class Dash extends Component {
  static _id = 'Dash'
  _id = Dash._id

  static _flag = Flag.Dash
  _flag = Flag.Dash

  velocity: number

  constructor(velocity: number = 0) {
    super()

    this.velocity = velocity
  }
}
