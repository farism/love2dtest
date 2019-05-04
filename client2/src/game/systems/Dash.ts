import { Aspect } from '../../ecs/Aspect'
import { Entity } from '../../ecs/Entity'
import { System } from '../../ecs/System'
import { Dash } from '../components/Dash'
import { GameObject } from '../components/GameObject'
import { Direction, Movement } from '../components/Movement'
import { SystemFlag } from '../flags'

export class DashSystem extends System {
  static _id = 'Dash'
  _id = DashSystem._id

  static _flag = SystemFlag.Dash
  _flag = DashSystem._flag

  static _aspect = new Aspect([Dash, GameObject, Movement])
  _aspect = DashSystem._aspect

  update = (dt: number) => {
    this.entities.forEach(entity => {
      const dash = entity.as(Dash)
      const gameObject = entity.as(GameObject)
      const movement = entity.as(Movement)

      if (!dash || !gameObject || !movement) {
        return
      }

      const body = gameObject.fixture.getBody()

      if (movement.direction == Direction.Left) {
        body.setLinearVelocity(-2000, 0)
      } else if (movement.direction == Direction.Right) {
        body.setLinearVelocity(2000, 0)
      }
    })
  }

  onAdd = (entity: Entity) => {
    const gameObject = entity.as(GameObject)

    gameObject && gameObject.fixture.getBody().setGravityScale(0)
  }

  onRemove = (entity: Entity) => {
    const gameObject = entity.as(GameObject)

    gameObject && gameObject.fixture.getBody().setGravityScale(1)
  }
}
