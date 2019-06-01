local constants = require 'src.game.components.constants'

local Input = {
  _meta = constants.Input
}

function Input.new(id)
  return {
    _meta = Input._meta,
    id = id
  }
end

return Input
