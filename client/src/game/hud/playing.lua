local State = require 'src.game.state'
local Ability = require 'src.game.components.ability'
local Player = require 'src.game.components.player'

local Playing = {}

local width, height = love.graphics.getDimensions()

local function keypressed(key)
  love.event.push('keypressed', key, nil, false, true)
end

local function keyreleased(key)
  love.event.push('keyreleased', key, nil, false, false)
end

local function money(player)
  local label = 'Money: ' .. tostring(player:as(Player).money)
  love.graphics.print(label, 10, 10, 0)
end

local function lives(player)
  local label = 'Lives: ' .. tostring(player:as(Player).lives)
  love.graphics.print(label, 10, 30, 0)
end

local function documents(player)
  local label = 'Documents: ' .. tostring(player:as(Player).documents)
  love.graphics.print(label, 10, 50, 0)
end

local function getPercent(player, key)
  local ability = player:as(Ability).abilities[key]
  local total = ability.cooldown or 0
  local current = total - ((ability.timers.cooldown or {}).running or 0)

  return (total - current) / total
end

local function arc(x, y, percent)
  local start = -math.pi / 2
  local finish = math.pi * 2

  if percent > 0 then
    love.graphics.arc(
      'fill',
      x,
      y,
      24,
      start + finish * percent,
      start + finish
    )
  end
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
  documents(player)

  if (player:has(Ability)) then
    cooldowns(player)
  end
end

return Playing
