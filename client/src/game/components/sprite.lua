local Asset = require 'src.game.utils.asset'
local constants = require 'src.game.components.constants'

local Sprite = {
  _meta = constants.Sprite
}

function Sprite.new(id, file, x, y, width, height)
  local image = Asset.getImage(file)

  local frame =
    love.graphics.newQuad(
    x or 0,
    y or 0,
    width or 32,
    height or 32,
    image:getDimensions()
  )

  return {
    _meta = Sprite._meta,
    id = id,
    file = file,
    image = image,
    frame = frame
  }
end

return Sprite
