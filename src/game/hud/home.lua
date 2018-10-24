local State = require 'game.state'

local Home = {}

function Home.update(dt, suit, width, height, game)
  if suit.Button('Play', (width - 300) / 2, 100, 300, 30).hit then
    game:setState(State.PLAYING)
  end

  if suit.Button('Upgrades', (width - 300) / 2, 160, 300, 30).hit then
    game:setState(State.UPGRADES)
  end
end

return Home
