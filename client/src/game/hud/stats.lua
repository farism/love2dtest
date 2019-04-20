local Stats = {}

local width, height = love.graphics.getDimensions()

function Stats.draw()
  local fps = 'FPS: ' .. tostring(love.timer.getFPS())

  love.graphics.printf(fps, 0, 50, width - 10, 'right')
end

return Stats
