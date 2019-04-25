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
