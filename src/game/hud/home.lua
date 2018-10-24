local States = require 'game.utils.states'
local Home = {}

local width, height = love.graphics.getDimensions()

local function settingsButton(dt, suit)
  local btnWidth = 75
  local btnHeight = 30
  local x = width - btnWidth - 10
  local y = height - btnHeight - 10

  return suit.Button('Settings', x, y, btnWidth, btnHeight)
end

local function playButton(dt, suit)
  local btnWidth = 300
  local btnHeight = 30
  local x = (width - btnWidth) / 2
  local y = (height - btnHeight) / 2

  return suit.Button('Play', x, y, btnWidth, btnHeight)
end

function Home.update(dt, suit)
  if playButton(dt, suit).hit then
    GameState = States.PLAYING
  end

  if settingsButton(dt, suit).hit then
  end
end

return Home
