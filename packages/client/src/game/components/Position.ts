import { ComponentFlag } from '../flags'

export class Position {
  static _id = 'Position'
  _id = Position._id

  static _flag = ComponentFlag.Position
  _flag = ComponentFlag.Position

  x: number
  y: number

  constructor(x: number = 0, y: number = 0) {
    this.x = x
    this.y = y
  }
}
