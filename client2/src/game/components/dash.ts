import { ComponentFlag } from '../flags'

export class Dash {
  static _id = 'Dash'
  _id = Dash._id

  static _flag = ComponentFlag.Dash
  _flag = ComponentFlag.Dash

  velocity: number

  constructor(velocity: number = 0) {
    this.velocity = velocity
  }
}
