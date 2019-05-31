import { Aspect } from '../../ecs/Aspect'
import { System } from '../../ecs/System'
import { GameObject } from '../components/GameObject'
import { Input } from '../components/Input'
import { Movement } from '../components/Movement'
import { Position } from '../components/Position'
import { Respawn } from '../components/Respawn'
import { SystemFlag } from '../flags'

export class InputMovementSystem extends System {
  static _id = 'InputMovement'
  _id = InputMovementSystem._id

  static _flag = SystemFlag.InputMovement
  _flag = InputMovementSystem._flag

  static _aspect = new Aspect(
    [GameObject, Input, Movement, Position],
    [Respawn]
  )
  _aspect = InputMovementSystem._aspect

  update = (dt: number) => {
    this.entities.forEach(entity => {
      const gameObject = entity.as(GameObject)
      const movement = entity.as(Movement)

      if (!gameObject || !movement) {
        return
      }

      const body = gameObject.fixture.getBody()
      let [velocityX, velocityY] = body.getLinearVelocity()

      if (movement.left) {
        velocityX = -300
      } else if (movement.right) {
        velocityX = 300
      }

      if (movement.jump && movement.jumpCount < 2) {
        velocityY = -1000
        movement.jump = false
        movement.jumpCount++
      }

      body.setLinearVelocity(velocityX, velocityY)
    })
  }
}
