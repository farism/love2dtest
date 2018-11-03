local Game = require 'game.game'

function love.load()
  love.graphics.setBackgroundColor(0.41, 0.53, 0.97)
  love.physics.setMeter(1)
  game = Game:new()
end

function love.update(dt)
  game:update(dt)
end

function love.draw()
  game:draw()
end

function love.keypressed(key, scancode, isrepeat)
  game:keyboard(key, scanecode, isrepeat, true)
end

function love.keyreleased(key, scancode)
  game:keyboard(key, scancode, false, false)
end

function love.mousepressed(x, y, button, istouch, presses)
  game:mouse(x, y, button, istouch, presses)
end
