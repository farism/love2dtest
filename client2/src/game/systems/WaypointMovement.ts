import { Aspect } from '../../ecs/Aspect'
import { System } from '../../ecs/System'
import { GameObject } from '../components/GameObject'
import { Direction, Movement } from '../components/Movement'
import { Position } from '../components/Position'
import { Point, Waypoint } from '../components/Waypoint'
import { SystemFlag } from '../flags'

type Axis = 'x' | 'y'

const shouldAdvance = (
  axis: Axis,
  velocity: number,
  from: Point,
  to: Partial<Point>
) => {
  const coordinate = to[axis]

  if (!coordinate) {
    return true
  }

  if (
    (velocity > 0 && from[axis] >= coordinate) ||
    (velocity < 0 && from[axis] <= coordinate) ||
    Math.abs(from[axis] - coordinate) < 1
  ) {
    return true
  }

  return false
}

const advance = (waypoint: Waypoint) => {
  if (waypoint.current + 1 === waypoint.path.length) {
    waypoint.current = 0
  } else {
    waypoint.current++
  }
}

const getCurrent = (defaults: Point, waypoint: Waypoint) => {
  const point = waypoint.path[waypoint.current]

  return {
    x: point.x || defaults.x,
    y: point.y || defaults.y,
  }
}

const getVelocityX = (angle: number, velocity: number) =>
  math.cos(angle) * velocity

const getVelocityY = (angle: number, velocity: number) =>
  math.sin(angle) * velocity

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
      entity.manager
      const waypoint = entity.as(Waypoint)
      const gameObject = entity.as(GameObject)
      const movement = entity.as(Movement)
      const position = entity.as(Position)

      if (!waypoint || !gameObject || !movement || !position) {
        return
      }

      if (!waypoint.active || !waypoint.path.length) {
        return
      }

      const point = waypoint.path[waypoint.current]

      const angle = math.atan2(
        (point.y || position.y) - position.y,
        (point.x || position.x) - position.x
      )

      const body = gameObject.fixture.getBody()

      const [velocityX, velocityY] = body.getLinearVelocity()

      const shouldAdvanceX = shouldAdvance('x', velocityX, position, point)

      const shouldAdvanceY = shouldAdvance('y', velocityY, position, point)

      let newVelocityX = velocityX

      let newVelocityY = velocityY

      if (shouldAdvanceX && shouldAdvanceY) {
        advance(waypoint)
      } else {
        if (!shouldAdvanceX) {
          newVelocityX = getVelocityX(angle, waypoint.speed)
        }

        if (point.y === null) {
          body.setGravityScale(1)
        } else {
          body.setGravityScale(0)

          if (!shouldAdvanceY) {
            newVelocityY = getVelocityY(angle, waypoint.speed)
          }
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
