import { Flag } from './flags'

export class Respawn {
  static _id = 'Respawn'
  _id = Respawn._id

  static _flag = Flag.Respawn
  _flag = Flag.Respawn

  waitTime: number

  constructor(waitTime: number = 0) {
    this.waitTime = waitTime
  }
}
