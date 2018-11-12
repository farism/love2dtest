local flux = require 'vendor.flux'
local Movement = require 'game.components.movement'
local Position = require 'game.components.position'
local Respawn = require 'game.components.respawn'

local Camera = {}
local LEFT_OFFSET = -WINDOW_WIDTH + 300
local RIGHT_OFFSET = -200

function Camera.new()
  local camera = {
    x = 0,
    y = 0,
    offset = RIGHT_OFFSET,
    direction = 'right',
    tween = nil
  }

  function camera:set()
    love.graphics.push()
    love.graphics.translate(
      math.floor(-self.x + 0.5),
      math.floor(-self.y + 0.5)
    )
  end

  function camera:clear()
    love.graphics.pop()
  end

  function camera:update(dt, player)
    local movement = player:as(Movement)
    local position = player:as(Position)
    local offset = self.offset

    if (player:has(Respawn)) then
      movement.direction = 'right'
    end

    if movement.direction == 'left' then
      offset = LEFT_OFFSET
    elseif movement.direction == 'right' then
      offset = RIGHT_OFFSET
    end

    if self.direction ~= movement.direction then
      self.tween = flux.group()
      self.tween:to(self, 3, {offset = offset}):ease('quadout')
    end

    if self.tween then
      self.tween:update(dt)
    end

    self.x = position.x + self.offset
    self.direction = movement.direction
  end

  return camera
end

return Camera
