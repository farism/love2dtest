import { ComponentFlag } from '../flags'

export enum Direction {
  Left = 'left',
  Right = 'right',
}

export class Movement {
  static _id = 'Movement'
  _id = Movement._id

  static _flag = ComponentFlag.Movement
  _flag = ComponentFlag.Movement

  direction: Direction = Direction.Right
  left: boolean = false
  right: boolean = false
  jump: boolean = false
  jumpCount: number = 0

  constructor() {}
}
