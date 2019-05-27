import { Aspect } from '../../ecs/Aspect'
import { System } from '../../ecs/System'
import { GameObject } from '../components/GameObject'
import { SystemFlag } from '../flags'
import {
  isChainShape,
  isCircleShape,
  isEdgeShape,
  isPolygonShape,
} from '../utils/fixture'

export class RenderSystem extends System {
  static _id = 'RenderSystem'
  _id = RenderSystem._id

  static _flag = SystemFlag.RenderSystem
  _flag = RenderSystem._flag

  static _aspect = new Aspect([GameObject])
  _aspect = RenderSystem._aspect

  draw = () => {
    this.entities.forEach(entity => {
      const gameObject = entity.as<GameObject>(GameObject)

      if (!gameObject) {
        return
      }

      const body = gameObject.fixture.getBody()
      const shape = gameObject.fixture.getShape()

      love.graphics.setColor(0.2, 0.2, 0.2, 1)

      if (isPolygonShape(shape)) {
        love.graphics.polygon(
          'fill',
          ...body.getWorldPoints(...shape.getPoints())
        )
      } else if (isCircleShape(shape)) {
        love.graphics.circle(
          'fill',
          body.getX(),
          body.getY(),
          shape.getRadius()
        )
      } else if (isChainShape(shape)) {
      } else if (isEdgeShape(shape)) {
      }
    })
  }
}
