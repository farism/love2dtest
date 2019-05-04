import { System } from '../../ecs/System'
import { SystemFlag } from '../flags'
import { Aspect } from '../../ecs/Aspect'
import { Waypoint, Point } from '../components/Waypoint'
import { Movement, Direction } from '../components/Movement'
import { Position } from '../components/Position'
import { GameObject } from '../components/GameObject'
import { Attack } from '../components/Attack'

enum Axis {
  X = 'x',
  Y = 'y',
}

const shouldAdvance = (
  axis: Axis,
  velocity: number,
  position: Position,
  next: Point
) => {
  if (!next[axis]) {
    return true
  } else if (velocity > 0 && position[axis] >= next[axis]) {
    return true
  } else {
    return false
  }
}
const advance = (waypoint: Waypoint) => {
  if (waypoint.current === waypoint.path.length) {
    waypoint.current = 0
  } else {
    waypoint.current++
  }
}

const getNext = (waypoint: Waypoint) => {
  const point = waypoint.path.length
    ? waypoint.path[0]
    : waypoint.path[waypoint.current + 1]

  return point ? point : { x: 0, y: 0 }
}

export class WaypointMovementSystem extends System {
  static _id = 'WaypointMovement'
  _id = WaypointMovementSystem._id

  static _flag = SystemFlag.WaypointMovement
  _flag = WaypointMovementSystem._flag

  static _aspect = new Aspect(
    [GameObject, Movement, Position, Waypoint],
    [
      /*Attack*/
    ]
  )
  _aspect = WaypointMovementSystem._aspect

  update = (dt: number) => {
    this.entities.forEach(entity => {
      const waypoint = entity.as(Waypoint)
      const gameObject = entity.as(GameObject)
      const movement = entity.as(Movement)
      const position = entity.as(Position)

      if (!waypoint || !gameObject || !movement || !position) {
        return
      }

      if (!waypoint.active) {
        return
      }

      const body = gameObject.fixture.getBody()
      body.setGravityScale(1)

      const next = getNext(waypoint)
      const angle = math.atan2(
        (next.y || position.y) - position.y,
        next.x - position.x
      )
      const [velocityX, velocityY] = body.getLinearVelocity()
      const shouldAdvanceX = shouldAdvance(Axis.X, velocityX, position, next)
      const shouldAdvanceY = shouldAdvance(Axis.Y, velocityY, position, next)

      let newVelocityX = 0
      let newVelocityY = 0

      if (shouldAdvanceX && shouldAdvanceY) {
        advance(waypoint)
      } else {
        if (!shouldAdvanceX) {
          newVelocityX = math.cos(angle) * waypoint.speed
        }

        if (next.y) {
          body.setGravityScale(0)

          if (!shouldAdvanceY) {
            newVelocityY = math.sin(angle) * waypoint.speed
          }
        } else {
          newVelocityY = velocityY
        }
      }

      if (newVelocityX < 0) {
        movement.direction = Direction.Left
      } else if (newVelocityX > 0) {
        movement.direction = Direction.Right
      }

      body.setLinearVelocity(newVelocityX, newVelocityY)
    })
  }
}
