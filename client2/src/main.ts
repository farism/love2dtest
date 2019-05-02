import { Game } from './game/Game'

let game: Game

love.load = (arg: table) => {
  love.graphics.setBackgroundColor(0.41, 0.53, 0.97)
  love.physics.setMeter(1)
  game = new Game()
}

love.update = (dt: number) => {
  if (game) {
    game.update(dt)
  }
}

love.draw = () => {
  if (game) {
    game.draw()
  }
}

love.keypressed = (key: KeyConstant, scancode: Scancode, isRepeat: boolean) => {
  game.keyboard(key, scancode, isRepeat, true)
}

love.keyreleased = (key: KeyConstant, scancode: Scancode) => {
  game.keyboard(key, scancode, false, false)
}

love.mousepressed = (
  x: number,
  y: number,
  button: number,
  isTouch: boolean
) => {
  game.mouse(x, y, isTouch)
}
