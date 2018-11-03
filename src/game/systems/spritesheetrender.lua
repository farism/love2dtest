local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Position = require 'game.components.position'
local Movement = require 'game.components.movement'
local Spritesheet = require 'game.components.spritesheet'

local aspect = Aspect:new({Spritesheet})
local SpritesheetRender = System:new('spritesheetrender', aspect)

local function getAnimation(spritesheet)
  return spritesheet.animations[spritesheet.currentAnimation]
end

local function setCurrent(spritesheet, movement)
  local action = 'stand'
  local direction = movement.direction or 'right'
  if movement then
    if movement.right or movement.left then
      action = 'walk'
    end
  end
  local animation = action .. '_' .. direction
  spritesheet.currentAnimation = animation
end

local function updateAnimation(spritesheet, elapsed)
  local animation = getAnimation(spritesheet)
  animation.step =
    math.ceil(
    elapsed * (animation.steps / animation.duration) % animation.steps
  )
end

local function updateCurrentFrame(spritesheet)
  local animation = getAnimation(spritesheet)
  spritesheet.currentFrame = animation.stepOffset + animation.step
end

function SpritesheetRender:update(dt)
  for _, entity in pairs(self.entities) do
    local spritesheet = entity:as(Spritesheet)
    local movement = entity:as(Movement)
    local elapsed = spritesheet.elapsed + dt

    setCurrent(spritesheet, movement)
    updateAnimation(spritesheet, elapsed)
    updateCurrentFrame(spritesheet)

    spritesheet.elapsed = elapsed
  end
end

function SpritesheetRender:draw()
  for _, entity in pairs(self.entities) do
    local spritesheet = entity:as(Spritesheet)
    local position = entity:as(Position)
    local idx = spritesheet.currentFrame
    local frame =
      love.graphics.draw(
      spritesheet.image,
      spritesheet.frames[idx],
      math.floor(position.x + 0.5),
      math.floor(position.y + 0.5)
    )
  end
end

return SpritesheetRender
