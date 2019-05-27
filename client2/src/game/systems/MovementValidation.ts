import { Aspect } from '../../ecs/Aspect'
import { System } from '../../ecs/System'
import { Attack } from '../components/Attack'
import { GameObject } from '../components/GameObject'
import { Movement } from '../components/Movement'
import { Position } from '../components/Position'
import { SystemFlag } from '../flags'
import { isStatic } from '../utils/fixture'

const getFixtureCountBelow = (x: number, y: number, world: World) => {
  let count = 0

  world.rayCast(x, y, x, y + 50, (fixture, x, y, xn, yn, frac) => {
    if (isStatic(fixture)) {
      count++
    }

    return 0
  })

  return count
}

export class MovementValidationSystem extends System {
  static _id = 'MovementValidation'
  _id = MovementValidationSystem._id

  static _flag = SystemFlag.MovementValidation
  _flag = MovementValidationSystem._flag

  static _aspect = new Aspect([Attack, GameObject, Movement])

  _aspect = MovementValidationSystem._aspect

  update = (dt: number) => {
    this.entities.forEach(entity => {
      const gameObject = entity.as(GameObject)
      const movement = entity.as(Movement)
      const position = entity.as(Position)

      if (!gameObject || !movement || !position) {
        return
      }

      const body = gameObject.fixture.getBody()

      const [velocityX, velocityY] = body.getLinearVelocity()

      const { x, y } = position

      const left = getFixtureCountBelow(x - 64, y, body.getWorld())

      const right = getFixtureCountBelow(x + 64, y, body.getWorld())

      if ((velocityX < 0 && left < right) || (velocityX > 0 && right < left)) {
        body.setLinearVelocity(0, velocityY)
      }
    })
  }
}
