import { Component } from '../../ecs/Component'
import { Flag } from './flags'

enum TriggerType {
  Spawn = 'spawn',
}

type Action = () => {}

export class Player extends Component {
  static _id = 'Player'
  _id = Player._id

  static _flag = Flag.Player
  _flag = Flag.Player

  type: TriggerType
  action: Action
  activated: boolean
  executed: boolean

  constructor(type: TriggerType = TriggerType.Spawn, action: Action) {
    super()

    this.type = type
    this.action = action
    this.activated = false
    this.executed = false
  }
}
