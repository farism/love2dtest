import { Aspect } from '../../ecs/Aspect'
import { System } from '../../ecs/System'
import { Container } from '../components/Container'
import { SystemFlag } from '../flags'

export class ContainerSystem extends System {
  static _id = 'Container'
  _id = ContainerSystem._id

  static _flag = SystemFlag.Container
  _flag = ContainerSystem._flag

  static _aspect = new Aspect([Container])
  _aspect = ContainerSystem._aspect

  update = (dt: number) => {
    this.entities.forEach(entity => {})
  }
}
