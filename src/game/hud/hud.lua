local suit = require 'vendor.suit.init'
local home = require 'game.hud.home'
local playing = require 'game.hud.playing'
local paused = require 'game.hud.paused'
local States = require 'game.utils.states'

local HUD = {}

function HUD:new()
  local hud = {}

  function hud:update(dt)
    if GameState == States.HOME then
      home.update(dt, suit)
    end

    -- playing.update(dt, suit)
    -- paused(dt, suit)

    -- if (self.home) then
    --   home(dt, suit)
    -- elseif (self.playing) then
    --   playing(dt, suit)
    -- elseif (self.paused) then
    --   paused(dt, suit)
    -- end
  end

  function hud:draw(dt)
    suit.draw()
  end

  return hud
end

return HUD
