local constants = require 'game.components.constants'

local Checkpoint = {
  _meta = constants.Checkpoint
}

function Checkpoint.new(id)
  return {
    _meta = Checkpoint._meta,
    id = id
  }
end

return Checkpoint
