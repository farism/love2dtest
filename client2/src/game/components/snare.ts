import { Component } from '../../ecs/Component'
import { Flag } from './flags'

export class Snare extends Component {
  static _id = 'Snare'
  _id = Snare._id

  static _flag = Flag.Snare
  _flag = Flag.Snare

  strength: number

  constructor(strength: number = 0) {
    super()

    this.strength = strength
  }
}
