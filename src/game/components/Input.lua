local constants = require('game/components/constants')

local Input = {
  _meta = constants.Input
}

function Input:new(id)
  return {
    _meta = Input._meta,
    id = id,
    left = false,
    right = false
  }
end

return Input
