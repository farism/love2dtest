local constants = require 'game.components.constants'

local Player = {
  _meta = constants.Player
}

function Player.new(id, alias)
  return {
    _meta = Player._meta,
    id = id,
    alias = alias
  }
end

return Player
