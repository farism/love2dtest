local Asset = require 'game.utils.Asset'
local constants = require 'game.components.constants'

local Sound = {
  _meta = constants.Sound
}

function Sound.new(id, file)
  local sound = Asset.getSound(file)

  return {
    _meta = Sound._meta,
    id = id,
    file = file,
    sound = sound
  }
end

return Sound
