import { Flag } from './flags'

type Direction = 'left' | 'right'

export class Movement {
  static _id = 'Movement'
  _id = Movement._id

  static _flag = Flag.Movement
  _flag = Flag.Movement

  direction: Direction = 'right'
  left: boolean = false
  right: boolean = false
  jump: boolean = false
  jumpCount: number = 0

  constructor() {}
}
