local constants = require 'game.components.constants'

local Dig = {
  _meta = constants.Dig
}

function Dig.new(id)
  return {
    _meta = Dig._meta,
    id = id
  }
end

return Dig
