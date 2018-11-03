local State = require 'game.state'

local GameOver = {}

local width, height = love.graphics.getDimensions()

function GameOver.update(dt, suit, player, game)
  if suit.Button('Restart', (width - 300) / 2, 100, 300, 30).hit then
    game:restart()
  end

  if suit.Button('Home', (width - 300) / 2, 160, 300, 30).hit then
    game:setState(State.HOME)
  end
end

function GameOver.draw(player, game)
end

return GameOver
