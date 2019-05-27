import { ComponentFlag } from '../flags'

type Direction = 'left' | 'right'

export class Movement {
  static _id = 'Movement'
  _id = Movement._id

  static _flag = ComponentFlag.Movement
  _flag = ComponentFlag.Movement

  direction: Direction = 'right'
  left: boolean = false
  right: boolean = false
  jump: boolean = false
  jumpCount: number = 0

  constructor() {}
}
