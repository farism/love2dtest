local constants = require('game/components/constants')

local Movement = {
  _meta = constants.Movement
}

function Movement:new(id)
  return {
    _meta = Movement._meta,
    id = id,
    left = false,
    right = false,
    jump = false
  }
end

return Movement
