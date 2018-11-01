local constants = require 'game.components.constants'
local Asset = require 'game.utils.Asset'

local Spritesheet = {
  _meta = constants.Spritesheet
}

function Spritesheet.new(id, file, frameWidth, frameHeight, animations)
  local image = Asset.getImage(file)
  local width, height = image:getDimensions()
  local currentAnimation = null
  local frames = {}

  local function buildAnimation(animation)
    for step = 1, animation.steps do
      table.insert(
        frames,
        love.graphics.newQuad(
          (step - 1) * frameWidth,
          (animation.row - 1) * frameHeight,
          frameWidth,
          frameHeight,
          width,
          height
        )
      )
    end
  end

  for name, animation in pairs(animations) do
    animation.stepOffset = #frames
    animation.rate = animation.steps / animation.duration
    buildAnimation(animation)
    currentAnimation = currentAnimation or name
  end

  return {
    _meta = Spritesheet._meta,
    id = id,
    file = file,
    image = image,
    frameWidth = width,
    frameHeight = height,
    frames = frames,
    currentFrame = 1,
    currentAnimation = currentAnimation,
    animations = animations,
    elapsed = 0
  }
end

return Spritesheet
