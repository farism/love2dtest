local constants = require 'game.components.constants'

local Player = {
  _meta = constants.Player
}

function Player.new(id)
  return {
    _meta = Player._meta,
    id = id,
    alias = alias,
    lives = 3,
    checkpoint = 0
  }
end

return Player
