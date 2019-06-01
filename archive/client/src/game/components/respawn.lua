local constants = require 'src.game.components.constants'

local Respawn = {
  _meta = constants.Respawn
}

function Respawn.new(id, waitTime)
  return {
    _meta = Respawn._meta,
    id = id,
    waitTime = waitTime or 3
  }
end

return Respawn
