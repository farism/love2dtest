import { WINDOW_WIDTH } from '../../conf'
import { Entity } from '../../ecs/entity'
import { Movement } from '../components/Movement'
import { Position } from '../components/Position'
import * as Tween from './tween'

const LEFT_OFFSET = -WINDOW_WIDTH + 300
const RIGHT_OFFSET = -200

type Direction = 'left' | 'right'

export class Camera {
  x: number
  y: number
  offset: number
  direction: Direction
  tween?: Tween.Tween

  constructor(initialDirection: Direction) {
    this.x = 0
    this.y = 0
    this.offset = 0
    this.direction = initialDirection
  }

  clear = () => {
    love.graphics.pop()
  }

  set = () => {
    love.graphics.push()
    love.graphics.translate(
      Math.floor(-this.x + 0.5),
      Math.floor(-this.y + 0.5)
    )
  }

  update = (target: Entity) => {
    const movement = target.as(Movement)
    const position = target.as(Position)

    if (!movement || !position) {
      return
    }

    let offset = this.offset

    if (movement.direction == 'left') {
      offset = LEFT_OFFSET
    } else if (movement.direction == 'right') {
      offset = RIGHT_OFFSET
    }

    if (movement.direction !== this.direction) {
      if (this.tween) {
        this.tween.kill()
      }

      this.tween = Tween.to(
        this,
        3,
        { offset },
        {
          onUpdate: (time: number) => {
            // print(time)
          },
        }
      )
    }

    this.x = position.x + this.offset
    this.direction = movement.direction
  }
}
