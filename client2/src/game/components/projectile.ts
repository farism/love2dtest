import { Component } from '../../ecs/Component'
import { Flag } from './flags'

export class Projectile extends Component {
  static _id = 'Projectile'
  _id = Projectile._id

  static _flag = Flag.Projectile
  _flag = Flag.Projectile

  constructor() {
    super()
  }
}
