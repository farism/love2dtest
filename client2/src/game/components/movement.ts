import { Component } from '../../ecs/Component'
import { Flag } from './flags'

type Direction = 'left' | 'right'

export class Dash {
  static _id = 'Dash'
  _id = Dash._id

  static _flag = Flag.Dash
  _flag = Flag.Dash

  direction: Direction = 'right'
  left: boolean = false
  right: boolean = false
  jump: boolean = false
  jumpCount: number = 0

  constructor() {}
}
