import { Flag } from './flags'

export class Position {
  static _id = 'Position'
  _id = Position._id

  static _flag = Flag.Position
  _flag = Flag.Position

  x: number
  y: number

  constructor(x: number = 0, y: number = 0) {
    this.x = x
    this.y = y
  }
}
