local States = require 'game.utils.states'
local Paused = {}

local width, height = love.graphics.getDimensions()

local function resume(dt, suit)
  local btnWidth = 75
  local btnHeight = 30
  local x = width - btnWidth - 10
  local y = 100

  return suit.Button('Settings', x, y, btnWidth, btnHeight)
end

local function restart(dt, suit)
  local btnWidth = 300
  local btnHeight = 30
  local x = (width - btnWidth) / 2
  local y = 160

  return suit.Button('Play', x, y, btnWidth, btnHeight)
end

function Paused.update(dt, suit)
  if resume(dt, suit).hit then
    GameState = States.PLAYING
  end
end

return Paused
