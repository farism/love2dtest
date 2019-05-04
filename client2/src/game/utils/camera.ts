import { WINDOW_WIDTH } from '../../conf'
import { Entity } from '../../ecs/entity'
import { Movement } from '../components/Movement'
import { Position } from '../components/Position'
import { Tween } from './tween'

const LEFT_OFFSET = -WINDOW_WIDTH + 300
const RIGHT_OFFSET = -200

type Direction = 'left' | 'right'

export class Camera {
  x: number
  y: number
  offset: number
  direction: Direction
  tween?: Tween<any>

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

  update = (dt: number, target: Entity) => {
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

    if (this.direction !== movement.direction) {
      this.tween = new Tween<{ offset: number }>({
        duration: 3,
        target: this,
        to: {
          offset: offset,
        },
      })

      // self.tween = flux.group()
      // self.tween:to(self, 3, {offset = offset}):ease('quadout')
    }

    this.x = position.x + this.offset
    this.direction = movement.direction
  }
}
