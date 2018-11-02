package.path = 'lib/?.lua;src/?.lua;' .. package.path

inspect = require 'vendor/inspect'

WINDOW_WIDTH = 800
WINDOW_HEIGHT = 480

function love.conf(t)
  t.console = true
  t.window.width = WINDOW_WIDTH
  t.window.height = WINDOW_HEIGHT
  t.highdpi = true
end
