local Asset = require('utils/Asset')
local constants = require('game/components/constants')

local Sprite = {
  _meta = constants.Sprite
}

function Sprite:new(id, file, x, y, width, height)
  local image = Asset.getImage(file)
  local imageWidth, imageHeight = image:getDimensions()
  local frame =
    love.graphics.newQuad(
    x or 0,
    y or 0,
    width or 32,
    height or 32,
    imageWidth,
    imageHeight
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
