import { Game } from './game/Game'

const game = new Game()

love.load = (arg: table) => {
  love.graphics.setBackgroundColor(0.41, 0.53, 0.97)
  love.physics.setMeter(1)
}

love.update = (dt: number) => {
  game.update(dt)
}

love.draw = () => {
  game.draw()
}
