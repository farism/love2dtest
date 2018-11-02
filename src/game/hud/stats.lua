local Stats = {}

function Stats.draw()
  love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 740, 50)
end

return Stats
