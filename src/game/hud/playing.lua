local State = require 'game.state'

local Playing = {}

local function keypress(key)
  love.event.push('keypressed', key)
end

function Playing.update(dt, suit, width, height, game)
  if suit.Button('Pause', (width - 300) - 10, 10, 300, 30).hit then
    game:setState(State.PAUSED)
  end

  if suit.Button('Jump', (width - 64) - 10, height - 64 - 10, 64, 64).hit then
    keypress('space')
  end

  if suit.Button('Shoot', width - 32 - 10, height - 64 - 32 - 32, 32, 32).hit then
    keypress('j')
  end

  if
    suit.Button('Util', width - 64 - 32 - 32, height - 64 - 32 - 32, 32, 32).hit
   then
    keypress('k')
  end

  if suit.Button('Swing', width - 64 - 32 - 32, height - 32 - 10, 32, 32).hit then
    keypress('k')
  end
end

return Playing
