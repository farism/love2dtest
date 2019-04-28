import { ComponentFlag } from '../flags'

export class Platform {
  static _id = 'Platform'
  _id = Platform._id

  static _flag = ComponentFlag.Platform
  _flag = ComponentFlag.Platform

  fall: number
  initialX: number
  initialY: number

  constructor(fall: number = 0, initialX: number = 0, initialY: number = 0) {
    this.fall = fall
    this.initialX = initialX
    this.initialY = initialY
  }
}
