local constants = require 'game.components.constants'

local Snare = {
  _meta = constants.Snare
}

function Snare.new(id)
  return {
    _meta = Snare._meta,
    id = id,
    strength = 1 -- number between 0 and 1
  }
end

return Snare
