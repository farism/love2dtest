import { System } from '../../ecs/System'
import { GameObject } from '../components/GameObject'
import { SystemFlag } from '../flags'

const isShapeType = <T extends Shape>(type: string, shape: Shape): shape is T =>
  shape.getType() === type

export class RenderSystem extends System {
  static _id = 'RenderSystem'
  _id = RenderSystem._id

  static _flag = SystemFlag.RenderSystem
  _flag = RenderSystem._flag

  draw = () => {
    this.entities.forEach(entity => {
      const gameObject = entity.as<GameObject>(GameObject)

      if (!gameObject) {
        return
      }

      const body = gameObject.fixture.getBody()
      const shape = gameObject.fixture.getShape()

      if (isShapeType<PolygonShape>('polygon', shape)) {
        love.graphics.polygon(
          'fill',
          ...body.getWorldPoints(...shape.getPoints())
        )
      } else if (isShapeType<CircleShape>('circle', shape)) {
        love.graphics.circle(
          'fill',
          body.getX(),
          body.getY(),
          shape.getRadius()
        )
      } else if (isShapeType<ChainShape>('chain', shape)) {
      } else if (isShapeType<EdgeShape>('edge', shape)) {
      }
    })
  }
}
