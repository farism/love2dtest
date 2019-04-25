import { Flag } from './flags'

export class Snare {
  static _id = 'Snare'
  _id = Snare._id

  static _flag = Flag.Snare
  _flag = Flag.Snare

  strength: number

  constructor(strength: number = 0) {
    this.strength = strength
  }
}
