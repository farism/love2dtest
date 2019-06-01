local State = require 'src.game.state'

local Home = {}

local width, height = love.graphics.getDimensions()

function Home.update(dt, suit, player, game)
  if suit.Button('Play', (width - 300) / 2, 100, 300, 30).hit then
    game:setState(State.PLAYING)
  end

  if suit.Button('Upgrades', (width - 300) / 2, 160, 300, 30).hit then
    game:setState(State.UPGRADES)
  end
end

function Home.draw(player, game)
end

return Home
