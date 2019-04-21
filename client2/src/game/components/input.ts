import { Component } from '../../ecs/Component'
import { Flag } from './flags'

export class Input extends Component {
  static _id = 'Input'
  _id = Input._id

  static _flag = Flag.Input
  _flag = Flag.Input

  constructor() {
    super()
  }
}
