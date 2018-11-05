local constants = require 'game.components.constants'

local Player = {
  _meta = constants.Player
}

function Player.new(id)
  return {
    _meta = Player._meta,
    id = id,
    alias = alias,
    money = 0,
    lives = 100,
    documents = 0,
    checkpoint = 1
  }
end

return Player
