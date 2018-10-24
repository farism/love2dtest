local State = require 'game.state'

local Upgrades = {}

function Upgrades.update(dt, suit, width, height, game)
  if suit.Button('Home', (width - 300) - 10, 10, 300, 30).hit then
    game:setState(State.HOME)
  end
end

return Upgrades
