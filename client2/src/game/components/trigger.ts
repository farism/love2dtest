import { ComponentFlag } from '../flags'

enum TriggerType {
  Spawn = 'spawn',
}

type Action = () => {}

export class Player {
  static _id = 'Player'
  _id = Player._id

  static _flag = ComponentFlag.Player
  _flag = ComponentFlag.Player

  type: TriggerType
  action: Action
  activated: boolean
  executed: boolean

  constructor(type: TriggerType = TriggerType.Spawn, action: Action) {
    this.type = type
    this.action = action
    this.activated = false
    this.executed = false
  }
}
