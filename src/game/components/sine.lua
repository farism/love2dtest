local constants = require 'game.components.constants'

local Sine = {
  _meta = constants.Sine
}

local types = {
  CIRCULAR = 'circular',
  WAVE = 'wave'
}

function Sine.new(id, amplitude, frequency, type)
  local sine = {
    _meta = Sine._meta,
    id = id,
    amplitude = amplitude or 1,
    frequency = frequency or 1,
    type = types.CIRCULAR
  }

  return sine
end

return Sine
