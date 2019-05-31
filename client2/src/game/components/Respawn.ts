import { ComponentFlag } from '../flags'
import { Timer } from '../utils/timer'

export class Respawn {
  static _id = 'Respawn'
  _id = Respawn._id

  static _flag = ComponentFlag.Respawn
  _flag = ComponentFlag.Respawn

  duration: number
  timer?: Timer

  constructor(duration: number = 0) {
    this.duration = duration
  }
}
