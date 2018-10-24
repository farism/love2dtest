local State = require 'game.state'

local Paused = {}

function Paused.update(dt, suit, width, height, game)
  if suit.Button('Resume', (800 - 300) / 2, 100, 300, 30).hit then
    game:setState(State.PLAYING)
  end

  if suit.Button('Restart', (800 - 300) / 2, 160, 300, 30).hit then
    game:restart()
  end

  if suit.Button('Main Menu', (800 - 300) / 2, 220, 300, 30).hit then
    game:setState(State.HOME)
  end
end

return Paused
