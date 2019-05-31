import { Aspect } from '../../ecs/Aspect'
import { System } from '../../ecs/System'
import { GameObject } from '../components/GameObject'
import { Movement } from '../components/Movement'
import { Position } from '../components/Position'
import { SystemFlag } from '../flags'

export class SyncDirectionSystem extends System {
  static _id = 'SyncDirection'
  _id = SyncDirectionSystem._id

  static _flag = SystemFlag.SyncDirection
  _flag = SyncDirectionSystem._flag

  static _aspect = new Aspect([GameObject, Position])
  _aspect = SyncDirectionSystem._aspect

  update = (dt: number) => {
    this.entities.forEach(entity => {
      const gameObject = entity.as(GameObject)
      const movement = entity.as(Movement)

      if (!gameObject || !movement) {
        return
      }

      const body = gameObject.fixture.getBody()
      const [velocityX, velocityY] = body.getLinearVelocity()

      if (velocityX < 0) {
        movement.direction = 'left'
      } else if (velocityX > 0) {
        movement.direction = 'right'
      }
    })
  }
}
