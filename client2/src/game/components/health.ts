import { Flag } from './flags'

export class Health {
  static _id = 'Health'
  _id = Health._id

  static _flag = Flag.Health
  _flag = Flag.Health

  hitpoints: number
  armor: number

  constructor(hitpoints: number = 0, armor: number = 0) {
    this.hitpoints = hitpoints
    this.armor = armor
  }
}
