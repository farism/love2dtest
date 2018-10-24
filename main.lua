local Game = require 'game.game'

local game

function love.load()
  love.graphics.setBackgroundColor(0.41, 0.53, 0.97)
  love.physics.setMeter(1)

  game = nil
  game = Game:new()
end

function love.update(dt)
  game:update(dt)
end

function love.draw()
  game:draw()
end

function love.keypressed(key, scancode, isRepeat)
  game:input(key, scanecode, isRepeat, true)
end

function love.keyreleased(key, scancode)
  game:input(key, scancode, false, false)
end
