import { System } from '../../ecs/System'
import { Aspect } from '../../ecs/Aspect'
import { SystemFlag } from '../flags'
import { Animation } from '../components/Animation'
import { Movement } from '../components/Movement'

export class SetCurrentAnimationSystem extends System {
  static _id = 'SetCurrentAnimation'
  _id = SetCurrentAnimationSystem._id

  static _flag = SystemFlag.SetCurrentAnimation
  _flag = SetCurrentAnimationSystem._flag

  static _aspect = new Aspect([Animation, Movement])
  _aspect = SetCurrentAnimationSystem._aspect

  update = (dt: number) => {
    this.entities.forEach(entity => {
      const animation = entity.as(Animation)
      const movement = entity.as(Movement)

      if (!animation || !movement) {
        return
      }

      let action = 'stand'

      if (movement.right || movement.left) {
        action = 'walk'
      }

      const newAnimation = `${action}_${movement.direction}`

      // if (newAnimation !== animation.currentSequence) {
      // animation.currentAnimation = newAnimation
      //   animation.currentFrame = 1
      // }
    })
  }
}
