local Asset = require 'src.game.utils.asset'
local constants = require 'src.game.components.constants'

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
