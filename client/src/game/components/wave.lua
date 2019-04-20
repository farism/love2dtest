local constants = require 'src.game.components.constants'

local Wave = {
  _meta = constants.Wave
}

local types = {
  CIRCULAR = 'circular',
  HORIZONTAL = 'horizontal',
  VERTICAL = 'vertical'
}

function Wave.new(id, type, x, y, amplitude, frequency)
  local wave = {
    _meta = Wave._meta,
    id = id,
    type = type,
    x = x or 0,
    y = y or 0,
    amplitude = amplitude or 1,
    frequency = frequency or 1
  }

  return wave
end

function Wave.newCircular(id, x, y, amplitude, frequency)
  local wave = Wave.new(id, types.CIRCULAR, x, y, amplitude, frequency)

  return wave
end

function Wave.newHorizontal(id, x, y, amplitude, frequency, direction)
  local wave = Wave.new(id, types.HORIZONTAL, x, y, amplitude, frequency)
  wave.direction = direction or 1

  return wave
end

function Wave.newVertical(id, x, y, amplitude, frequency)
  local wave = Wave.new(id, types.VERTICAL, x, y, amplitude, frequency)
  wave.direction = direction or 1

  return wave
end

return Wave
