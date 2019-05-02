import { Aspect } from '../../ecs/Aspect'
import { System } from '../../ecs/System'
import { SystemFlag } from '../flags'
import { Sprite } from '../components/Sprite'
import { Animation } from '../components/Animation'

export class AnimateSpriteSystem extends System {
  static _id = 'AnimateSprite'
  _id = AnimateSpriteSystem._id

  static _flag = SystemFlag.AnimateSprite
  _flag = AnimateSpriteSystem._flag

  static _aspect = new Aspect([Animation, Sprite])
  _aspect = AnimateSpriteSystem._aspect

  update = (dt: number) => {
    this.entities.forEach(entity => {
      const animation = entity.as(Animation)
      const sprite = entity.as(Sprite)

      if (!animation || !sprite) {
        return
      }

      const elapsedTime = animation.elapsedTime + dt
      const sequence = animation.sequences[animation.currentSequence]

      if (elapsedTime > sequence.step) {
        animation.elapsedTime = elapsedTime - sequence.step

        animation.currentFrame =
          animation.currentFrame === sequence.length
            ? (animation.currentFrame = 1)
            : (animation.currentFrame = animation.currentFrame + 1)
      } else {
        animation.elapsedTime = elapsedTime
      }

      // sprite.frame = sequence.frames[animation.currentFrame]
    })
  }
}
