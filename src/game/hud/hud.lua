local suit = require 'vendor.suit.init'
local State = require 'game.state'
local Ability = require 'game.components.ability'
local Timer = require 'game.components.timer'
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

local function getPercent(ability, timer, key)
  local total = ability.abilities[key].cooldown or 0
  local current = (timer.timers[key] or {}).cooldown or 0

  return (total - current) / total
end

local function drawCooldownArc(x, y, percent)
  local start = -math.pi / 2
  local finish = math.pi * 2

  love.graphics.arc('fill', x, y, 24, start + finish * percent, start + finish)
end

local function drawAbilityCooldowns(player)
  local width, height = love.graphics.getDimensions()
  local ability = player:as(Ability)
  local timer = player:as(Timer)
  local throw = getPercent(ability, timer, 'throw')
  local dash = getPercent(ability, timer, 'dash')
  local dig = getPercent(ability, timer, 'dig')

  love.graphics.setColor(0, 0, 0, 0.5)
  drawCooldownArc(width - 24 - 10, height - 64 - 24 - 48, throw)
  drawCooldownArc(width - 64 - 24 - 48, height - 24 - 10, dash)
  -- drawCooldownArc(width - 24 - 10, height - 64 - 24 - 48, dig)
  love.graphics.setColor(255, 255, 255)
end

function HUD:new(game)
  local hud = {}

  function hud:update(dt, game)
    local width, height = love.graphics.getDimensions()

    for _, screen in pairs(screens[game.state] or {}) do
      screen.update(dt, suit, width, height, game)
    end
  end

  function hud:draw(player)
    suit.draw()

    if (player) then
      drawAbilityCooldowns(player)
    end
  end

  return hud
end

return HUD
