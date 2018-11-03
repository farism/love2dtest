local suit = require 'vendor.suit.init'
local State = require 'game.state'
local gameover = require 'game.hud.gameover'
local home = require 'game.hud.home'
local paused = require 'game.hud.paused'
local playing = require 'game.hud.playing'
local upgrades = require 'game.hud.upgrades'
local stats = require 'game.hud.stats'

local HUD = {}

local screens = {
  [State.GAMEOVER] = gameover,
  [State.HOME] = home,
  [State.PAUSED] = paused,
  [State.PLAYING] = playing,
  [State.UPGRADES] = upgrades
}

function HUD.new(state)
  local hud = {}

  function hud:update(dt, player, game)
    screens[game.state].update(dt, suit, player, game)
  end

  function hud:draw(player, game)
    -- fps and stats
    stats.draw()

    -- suit ui drawing
    suit.draw()

    -- additional drawing
    screens[game.state].draw(player, game)
  end

  return hud
end

return HUD
