import { ComponentFlag } from '../flags'

export class Player {
  static _id = 'Player'
  _id = Player._id

  static _flag = ComponentFlag.Player
  _flag = ComponentFlag.Player

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
    this.alias = alias
    this.money = money
    this.lives = lives
    this.documents = documents
    this.checkpoint = checkpoint
  }
}
