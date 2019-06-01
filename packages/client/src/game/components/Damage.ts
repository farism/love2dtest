import { ComponentFlag } from '../flags'

export class Damage {
  static _id = 'Damage'
  _id = Damage._id

  static _flag = ComponentFlag.Damage
  _flag = ComponentFlag.Damage

  hitpoints: number

  constructor(hitpoints: number = 0) {
    this.hitpoints = hitpoints
  }
}
