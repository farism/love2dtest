local suit = require 'vendor.suit.init'

local HUD = {}

function HUD:new()
  local hud = {}

  function hud:update(dt)
    -- if suit.Button('Hello, World!', 100, 100, 300, 30).hit then
    --   show_message = true
    -- end
    -- if show_message then
    --   suit.Label('How are you today?', 100, 150, 300, 30)
    -- end
  end

  function hud:draw(dt)
    suit.draw()
  end

  return hud
end

return HUD
