local constants = require 'game.components.constants'

local Checkpoint = {
  _meta = constants.Checkpoint
}

function Checkpoint.new(id, index)
  return {
    _meta = Checkpoint._meta,
    id = id,
    index = index or 1,
    visited = false
  }
end

return Checkpoint
