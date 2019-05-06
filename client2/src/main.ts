import { Game } from './game/Game'

love.load = () => {
  love.graphics.setBackgroundColor(0.41, 0.53, 0.97)
  love.physics.setMeter(1)

  const game = new Game()

  love.update = (...args) => game.update(...args)
  love.draw = (...args) => game.draw(...args)
  love.keypressed = (...args) => game.keypressed(...args)
  love.keyreleased = (...args) => game.keyreleased(...args)
  love.mousepressed = (...args) => game.mousepressed(...args)
  love.mousereleased = (...args) => game.mousereleased(...args)
  love.mousemoved = (...args) => game.mousemoved(...args)
}
