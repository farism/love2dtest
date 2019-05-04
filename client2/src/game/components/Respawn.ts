import { ComponentFlag } from '../flags'

export class Respawn {
  static _id = 'Respawn'
  _id = Respawn._id

  static _flag = ComponentFlag.Respawn
  _flag = ComponentFlag.Respawn

  duration: number
  timer: number = 0

  constructor(duration: number = 0) {
    this.duration = duration
  }
}
