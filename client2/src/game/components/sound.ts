import { Component } from '../../ecs/Component'
import { Flag } from './flags'

export class Sound extends Component {
  static _id = 'Sound'
  _id = Sound._id

  static _flag = Flag.Sound
  _flag = Flag.Sound

  filepath: string
  sound: any

  constructor(filepath: string = '', sound: any) {
    super()

    this.filepath = filepath
    this.sound = sound
  }
}
