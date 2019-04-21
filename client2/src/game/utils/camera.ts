import { Entity } from '../../ecs/entity'

// local LEFT_OFFSET = -WINDOW_WIDTH + 300
// local RIGHT_OFFSET = -200

type Direction = 'left' | 'right'
type Tween = any

export class Camera {
  x: number
  y: number
  offset: number
  direction: Direction
  tween: Tween

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
    // const movement = this.target.as(Movement)
    // const position = this.target.as(Position)
    // const offset = this.offset
  }
}

//   function camera:update(dt, player)
//     local movement = player:as(Movement)
//     local position = player:as(Position)
//     local offset = self.offset

//     if movement.direction == 'left' then
//       offset = LEFT_OFFSET
//     elseif movement.direction == 'right' then
//       offset = RIGHT_OFFSET
//     end

//     if self.direction ~= movement.direction then
//       self.tween = flux.group()
//       self.tween:to(self, 3, {offset = offset}):ease('quadout')
//     end

//     if self.tween then
//       self.tween:update(dt)
//     end

//     self.x = position.x + self.offset
//     self.direction = movement.direction
//   end

//   return camera
// end

// return Camera
