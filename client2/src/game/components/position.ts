import { Component } from '../../ecs/Component'
import { Flag } from './flags'

export class Position extends Component {
  static _id = 'Position'
  _id = Position._id

  static _flag = Flag.Position
  _flag = Flag.Position

  x: number
  y: number

  constructor(x: number = 0, y: number = 0) {
    super()

    this.x = x
    this.y = y
  }
}
