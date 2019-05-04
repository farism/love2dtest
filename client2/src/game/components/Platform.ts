import { ComponentFlag } from '../flags'

export class Platform {
  static _id = 'Platform'
  _id = Platform._id

  static _flag = ComponentFlag.Platform
  _flag = ComponentFlag.Platform

  duration: number
  initialX: number
  initialY: number
  timer?: number

  constructor(
    duration: number = 0,
    initialX: number = 0,
    initialY: number = 0
  ) {
    this.duration = duration
    this.initialX = initialX
    this.initialY = initialY
  }
}
