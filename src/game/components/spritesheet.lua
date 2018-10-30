local constants = require 'game.components.constants'
local Asset = require 'game.utils.Asset'

local Spritesheet = {
  _meta = constants.Spritesheet
}
local function buildFrames(image, columns, rows)
  local width, height = image:getDimensions()
  local frames = {}
  local frameWidth = width / columns
  local frameHeight = height / rows

  for n = 1, columns do
    for m = 1, rows do
      local quad =
        table.insert(
        frames,
        love.graphics.newQuad(
          0 + (n - 1) * frameWidth,
          0 + (m - 1) * frameHeight,
          frameWidth,
          frameHeight,
          width,
          height
        )
      )
    end
  end

  return frames
end

-- animation {
-- id
-- startframe
-- length
-- speed
-- currentframe
-- }

-- function Spritesheet.new(id, file, animations, frames)
function Spritesheet.new(id, file, columns, rows, width, height, frames)
  local image = Asset.getImage(file)
  local frames = buildFrames(image, columns or 1, rows or 1)

  return {
    _meta = Spritesheet._meta,
    id = id,
    file = file,
    image = image,
    frames = frames
  }
end

return Spritesheet
