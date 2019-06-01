import { Aspect } from '../../ecs/Aspect'
import { Manager } from '../../ecs/manager'
import { System } from '../../ecs/System'
import { Parallax } from '../components/Parallax'
import { SystemFlag } from '../flags'
import { Camera } from '../utils/camera'

export class ParallaxRenderSystem extends System {
  static _id = 'ParallaxRenderSystem'
  _id = ParallaxRenderSystem._id

  static _flag = SystemFlag.ParallaxRender
  _flag = ParallaxRenderSystem._flag

  static _aspect = new Aspect([Parallax])
  _aspect = ParallaxRenderSystem._aspect

  camera: Camera

  constructor(manager: Manager, camera: Camera) {
    super(manager)

    this.camera = camera
  }

  draw = () => {
    this.entities.forEach(entity => {
      const parallax = entity.as(Parallax)

      if (!parallax) {
        return
      }

      parallax.layers.forEach(
        ({ image, offsetX = 0, offsetY = 0, quad, ratio }) => {
          love.graphics.draw(
            image,
            quad,
            this.camera.x,
            0,
            0,
            1,
            1,
            offsetX + this.camera.x * ratio,
            offsetY + this.camera.y * ratio
          )
        }
      )
    })
  }
}
