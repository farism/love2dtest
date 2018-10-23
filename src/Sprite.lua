-- imports

-- module namespace

local Sprite = {}

-- module functions

function Sprite.create(file)
  local image = love.graphics.newImage(file)
  local width, height = image:getDimensions()

  return {
    image = image,
    width = width,
    height = height
  }
end

function Sprite.draw(sprite, x, y)
  love.graphics.draw(sprite.image, x, y)
end

-- private functions

return Sprite
