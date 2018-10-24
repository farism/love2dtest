local State = require 'game.state'

local Home = {}

function Home.update(dt, suit, width, height, game)
  if suit.Button('Play', (width - 300) / 2, (height - 30) / 2, 300, 30).hit then
    game:setState(State.PLAYING)
  end
end

return Home
