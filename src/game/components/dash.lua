local constants = require 'game.components.constants'

local Dash = {
  _meta = constants.Dash
}

function Dash.new(id)
  return {
    _meta = Dash._meta,
    id = id,
    duration = 0.2
  }
end

return Dash
