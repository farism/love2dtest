local constants = require 'game.components.constants'

local Respawn = {
  _meta = constants.Respawn
}

function Respawn.new(id)
  return {
    _meta = Respawn._meta,
    id = id,
    waitTime = 2
  }
end

return Respawn
