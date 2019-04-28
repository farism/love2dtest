import { ComponentFlag } from '../flags'

export class Sound {
  static _id = 'Sound'
  _id = Sound._id

  static _flag = ComponentFlag.Sound
  _flag = ComponentFlag.Sound

  filepath: string
  sound: any

  constructor(filepath: string = '', sound: any) {
    this.filepath = filepath
    this.sound = sound
  }
}
