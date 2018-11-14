local constants = require 'game.components.constants'

local Player = {
  _meta = constants.Player
}

function Player.new(id, alias, money, lives, documents, checkpoint)
  return {
    _meta = Player._meta,
    id = id,
    alias = alias or '',
    money = money or 0,
    lives = lives or 100,
    documents = documents or 0,
    checkpoint = checkpoint or 1
  }
end

return Player
