import { System } from '../../ecs/System'
import { SystemFlag } from '../flags'
import { Aspect } from '../../ecs/Aspect'
import { GameObject } from '../components/GameObject'
import { Position } from '../components/Position'

export class SyncBodyPositionSystem extends System {
  static _id = 'SyncBodyPosition'
  _id = SyncBodyPositionSystem._id

  static _flag = SystemFlag.SyncBodyPosition
  _flag = SyncBodyPositionSystem._flag

  static _aspect = new Aspect([GameObject, Position])
  _aspect = SyncBodyPositionSystem._aspect

  update = (dt: number) => {
    this.entities.forEach(entity => {
      const gameObject = entity.as(GameObject)
      const position = entity.as(Position)

      if (!gameObject || !position) {
        return
      }

      const body = gameObject.fixture.getBody()
      const [x, y] = body.getPosition()

      position.x = x
      position.y = y
    })
  }
}
