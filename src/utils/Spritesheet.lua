local Sprite = require('Sprite')

local Spritesheet = {}

local function buildFrames(sprite, columns)
  local frames = {}
  local width = sprite.width / columns

  for n = 1, columns do
    local x = 0 + (n - 1) * width

    frames[n] =
      love.graphics.newQuad(
      x,
      0,
      width,
      sprite.height,
      sprite.width,
      sprite.height
    )
  end

  return frames
end

function Spritesheet.create(file, columns, duration)
  local sprite = Sprite.create(file)
  local frames = buildFrames(sprite, columns)

  return {
    sprite = sprite,
    frames = frames,
    columns = columns,
    duration = duration,
    frame_length = duration / columns,
    current_frame = 1,
    elapsed_time = 0
  }
end

function Spritesheet.update(spritesheet, dt)
  local elapsed = spritesheet.elapsed_time + dt

  if elapsed >= spritesheet.frame_length then
    spritesheet.elapsed_time = elapsed - spritesheet.frame_length

    if (spritesheet.current_frame == spritesheet.columns) then
      spritesheet.current_frame = 1
    else
      spritesheet.current_frame = spritesheet.current_frame + 1
    end
  else
    spritesheet.elapsed_time = elapsed
  end

  return spritesheet
end

function Spritesheet.draw(spritesheet, x, y)
  love.graphics.draw(
    spritesheet.sprite.image,
    spritesheet.frames[spritesheet.current_frame],
    x,
    y
  )
end

return Spritesheet
