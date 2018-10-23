local Asset = require 'utils.Asset'
local constants = require 'game.components.constants'

local Music = {
  _meta = constants.Music
}

function Music:new(id, file)
  local sound = Asset.getMusic(file)

  return {
    _meta = Music._meta,
    id = id,
    file = file,
    sound = sound
  }
end

return Music
