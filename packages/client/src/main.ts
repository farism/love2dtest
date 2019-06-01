import { Game } from './game/Game'

const game = new Game()
const fps = 1 / 60
let nextTime = love.timer.getTime()

love.load = () => {
  love.graphics.setBackgroundColor(0.41, 0.53, 0.97)
}

love.update = (...args) => {
  nextTime = nextTime + fps

  game.update(...args)
}

love.draw = (...args) => {
  game.draw(...args)

  const curTime = love.timer.getTime()

  if (nextTime <= curTime) {
    nextTime = curTime
    return
  }

  love.timer.sleep(nextTime - curTime)
}

love.keypressed = (...args) => game.keypressed(...args)

love.keyreleased = (...args) => game.keyreleased(...args)

love.mousepressed = (...args) => game.mousepressed(...args)

love.mousereleased = (...args) => game.mousereleased(...args)

love.mousemoved = (...args) => game.mousemoved(...args)
