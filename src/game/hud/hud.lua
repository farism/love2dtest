local suit = require 'vendor.suit.init'

local HUD = {}

function HUD:new()
  local hud = {}

  function hud:update(dt)
    if suit.Button('Play', (800 - 300) / 2, 100, 300, 30).hit then
    end

    if suit.Button('Settings', (800 - 300) / 2, 160, 300, 30).hit then
    end
  end

  function hud:draw(dt)
    suit.draw()
  end

  return hud
end

return HUD
