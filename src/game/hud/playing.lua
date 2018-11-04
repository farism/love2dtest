local State = require 'game.state'
local Ability = require 'game.components.ability'
local Player = require 'game.components.player'
local Timer = require 'game.components.timer'

local Playing = {}

local width, height = love.graphics.getDimensions()

local function keypressed(key)
  love.event.push('keypressed', key, nil, false, true)
end

local function keyreleased(key)
  love.event.push('keyreleased', key, nil, false, false)
end

local function money(player)
  love.graphics.print('Money: ' .. tostring(player:as(Player).money), 10, 10, 0)
end

local function lives(player)
  love.graphics.print('Lives: ' .. tostring(player:as(Player).lives), 10, 30, 0)
end

local function getPercent(player, key)
  local ability = player:as(Ability)
  local timer = player:as(Timer)
  local total = ability.abilities[key].cooldown or 0
  local current = (timer.timers[key] or {}).cooldown or 0

  return (total - current) / total
end

local function arc(x, y, percent)
  local start = -math.pi / 2
  local finish = math.pi * 2

  love.graphics.arc('fill', x, y, 24, start + finish * percent, start + finish)
end

local function cooldowns(player)
  love.graphics.setColor(0, 0, 0, 0.5)
  arc(width - 24 - 10, height - 64 - 24 - 48, getPercent(player, 'throw'))
  arc(width - 64 - 24 - 48, height - 24 - 10, getPercent(player, 'dash'))
  love.graphics.setColor(255, 255, 255)
end

function Playing.update(dt, suit, player, game)
  if suit.Button('Jump', (width - 64) - 10, height - 64 - 10, 64, 64).hit then
    keypressed('space')
  end

  if suit.Button('Throw', width - 48 - 10, height - 64 - 48 - 48, 48, 48).hit then
    keypressed('j')
  end

  if
    suit.Button('Util', width - 64 - 48 - 48, height - 64 - 48 - 48, 48, 48).hit
   then
  -- keypressed('k')
  end

  if suit.Button('Dash', width - 64 - 48 - 48, height - 48 - 10, 48, 48).hit then
    keypressed('k')
  end

  if suit.Button('Pause', (width - 300) - 10, 10, 300, 30).hit then
    game:setState(State.PAUSED)
  end
end

function Playing.draw(player, game)
  money(player)
  lives(player)
  cooldowns(player)
end

return Playing
