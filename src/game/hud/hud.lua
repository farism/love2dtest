local suit = require 'vendor.suit.init'
local State = require 'game.state'
local home = require 'game.hud.home'
local upgrades = require 'game.hud.upgrades'
local playing = require 'game.hud.playing'
local paused = require 'game.hud.paused'

local screens = {
  [State.HOME] = {home},
  [State.UPGRADES] = {upgrades},
  [State.PLAYING] = {playing},
  [State.PAUSED] = {paused}
}

local HUD = {}

function HUD:new()
  local hud = {}

  function hud:update(dt, game)
    local width, height = love.graphics.getDimensions()

    for _, screen in pairs(screens[game.state] or {}) do
      screen.update(dt, suit, width, height, game)
    end
  end

  function hud:draw(dt)
    suit.draw()
  end

  return hud
end

return HUD
