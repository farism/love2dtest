import { Component } from '../../ecs/Component'
import { Flag } from './flags'

export class Player extends Component {
  static _id = 'Player'
  _id = Player._id

  static _flag = Flag.Player
  _flag = Flag.Player

  alias: string
  money: number
  lives: number
  documents: number
  checkpoint: number

  constructor(
    alias: string = '',
    money: number = 0,
    lives: number = 0,
    documents: number = 0,
    checkpoint: number = 0
  ) {
    super()

    this.alias = alias
    this.money = money
    this.lives = lives
    this.documents = documents
    this.checkpoint = checkpoint
  }
}
