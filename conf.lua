package.path = 'lib/?.lua;src/?.lua;' .. package.path

inspect = require 'vendor/inspect'

function love.conf(t)
  t.console = true
  t.window.width = 800
  t.window.height = 480
  t.highdpi = true
end
