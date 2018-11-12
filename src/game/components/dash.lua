local constants = require 'game.components.constants'

local Dash = {
  _meta = constants.Dash
}

function Dash.new(id, hitpoints)
  return {
    _meta = Dash._meta,
    id = id,
    velocity = {0, 0}
  }
end

return Dash
