import { Flag } from './flags'

export class Sprite {
  static _id = 'Sprite'
  _id = Sprite._id

  static _flag = Flag.Sprite
  _flag = Flag.Sprite

  filepath: string
  x: number
  y: number
  width: number
  height: number

  constructor(
    filepath: string = '',
    x: number = 0,
    y: number = 0,
    width: number = 0,
    height: number = 0
  ) {
    this.filepath = filepath
    this.x = x
    this.y = y
    this.width = width
    this.height = height
  }
}
