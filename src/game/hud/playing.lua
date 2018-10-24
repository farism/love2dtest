local State = require 'game.state'

local Playing = {}

function Playing.update(dt, suit, width, height, game)
  if suit.Button('Pause', (width - 300) - 10, 10, 300, 30).hit then
    game:setState(State.PAUSED)
  end
end

return Playing
