local constants = require 'game.components.constants'

local Attack = {
  _meta = constants.Attack
}

function Attack.new(id, target)
  return {
    _meta = Attack._meta,
    id = id,
    target = target
  }
end

return Attack
