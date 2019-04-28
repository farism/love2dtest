import { ComponentFlag } from '../flags'

export class Respawn {
  static _id = 'Respawn'
  _id = Respawn._id

  static _flag = ComponentFlag.Respawn
  _flag = ComponentFlag.Respawn

  waitTime: number

  constructor(waitTime: number = 0) {
    this.waitTime = waitTime
  }
}
