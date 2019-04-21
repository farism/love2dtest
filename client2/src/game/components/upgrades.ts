import { Component } from '../../ecs/component'
import { Flag } from './flags'

export class Upgrades extends Component {
  static _id = 'Upgrades'
  _id = Upgrades._id

  static _flag = Flag.Upgrades
  _flag = Flag.Upgrades

  passive: number
  throw: number
  dash: number
  grapple: number
  dig: number

  constructor(
    passive: number,
    throw_: number,
    dash: number,
    grapple: number,
    dig: number
  ) {
    super()

    this.passive = passive
    this.throw = throw_
    this.dash = dash
    this.grapple = grapple
    this.dig = dig
  }
}