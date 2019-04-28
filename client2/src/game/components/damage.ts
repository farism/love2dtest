import { ComponentFlag } from '../flags'

export class Checkpoint {
  static _id = 'Checkpoint'
  _id = Checkpoint._id

  static _flag = ComponentFlag.Checkpoint
  _flag = ComponentFlag.Checkpoint

  hitpoints: number

  constructor(hitpoints: number = 0) {
    this.hitpoints = hitpoints
  }
}
