local State = require 'game.state'

local Playing = {}

local function keypressed(key)
  love.event.push('keypressed', key, nil, false, true)
end

local function keyreleased(key)
  love.event.push('keyreleased', key, nil, false, false)
end

function Playing.update(dt, suit, width, height, game)
  if suit.Button('Jump', (width - 64) - 10, height - 64 - 10, 64, 64).hit then
    keypressed('space')
  end

  if suit.Button('Throw', width - 48 - 10, height - 64 - 48 - 48, 48, 48).hit then
    keypressed('j')
  end

  if
    suit.Button('Util', width - 64 - 48 - 48, height - 64 - 48 - 48, 48, 48).hit
   then
    keypressed('k')
  end

  if suit.Button('Dash', width - 64 - 48 - 48, height - 48 - 10, 48, 48).hit then
    keypressed('k')
  end

  if suit.Button('Pause', (width - 300) - 10, 10, 300, 30).hit then
    game:setState(State.PAUSED)
  end
end

return Playing
