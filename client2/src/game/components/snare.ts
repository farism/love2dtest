import { ComponentFlag } from '../flags'

export class Snare {
  static _id = 'Snare'
  _id = Snare._id

  static _flag = ComponentFlag.Snare
  _flag = ComponentFlag.Snare

  strength: number

  constructor(strength: number = 0) {
    this.strength = strength
  }
}
