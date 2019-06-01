import { Aspect } from '../../ecs/Aspect'
import { System } from '../../ecs/System'
import { SystemFlag } from '../flags'
import { Position } from '../components/Position'
import { Sprite } from '../components/Sprite'

export class SpriteRenderSystem extends System {
  static _id = 'SpriteRenderSystem'
  _id = SpriteRenderSystem._id

  static _flag = SystemFlag.SpriteRender
  _flag = SpriteRenderSystem._flag

  static _aspect = new Aspect([Position, Sprite])
  _aspect = SpriteRenderSystem._aspect

  draw = () => {
    this.entities.forEach(entity => {
      const position = entity.as(Position)
      const sprite = entity.as(Sprite)

      if (position && sprite && sprite.image) {
        love.graphics.draw(
          sprite.image,
          sprite.frame,
          Math.floor(position.x + 0.5),
          Math.floor(position.y + 0.5)
        )
      }
    })
  }
}
