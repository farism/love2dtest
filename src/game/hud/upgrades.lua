local State = require 'game.state'

local Upgrades = {}

local width, height = love.graphics.getDimensions()

function Upgrades.update(dt, suit, player, game)
  if suit.Button('Home', (width - 300) - 10, 10, 300, 30).hit then
    game:setState(State.HOME)
  end
end

function Upgrades.draw(player, game)
end

return Upgrades
