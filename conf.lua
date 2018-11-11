package.path = 'lib/?.lua;src/?.lua;' .. package.path

inspect = require 'vendor/inspect'

WINDOW_WIDTH = 800
WINDOW_HEIGHT = 480

function math.sign(x)
  return (x < 0 and -1) or 1
end

function love.conf(t)
  t.console = true
  t.window.width = WINDOW_WIDTH
  t.window.height = WINDOW_HEIGHT
  t.highdpi = true
end
