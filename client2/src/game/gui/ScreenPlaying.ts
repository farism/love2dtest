// import { Game } from '../Game'
import { Entity } from '../../ecs/Entity'
import { Abilities } from '../components/Abilities'
import { State } from '../State'
import { GuiCore } from './GuiCore'

interface Game {
  player: Entity
  state: State
  setState: (state: State) => void
}

const [w, h] = love.graphics.getDimensions()

const arc = (x: number, y: number, percent: number) => {
  const start = -Math.PI / 2
  const finish = Math.PI * 2

  if (percent > 0) {
    love.graphics.arc(
      'fill',
      x,
      y,
      24,
      start + finish * percent,
      start + finish
    )
  }
}

const drawCooldowns = (abilities: Abilities) => {
  const throwPct = abilities.abilities.throw.timers.cooldown.currentPercent
  const dashPct = abilities.abilities.dash.timers.cooldown.currentPercent

  love.graphics.setColor(0, 0, 0, 0.5)
  arc(w - 24 - 10, h - 64 - 24 - 48, throwPct)
  arc(w - 64 - 24 - 48, h - 24 - 10, dashPct)
  love.graphics.setColor(255, 255, 255, 1)
}

export const update = (core: GuiCore, game: Game) => {
  if (core.button('jump', 'Jump', w - 74, h - 74, 64, 64).clicked) {
    love.event.push('keypressed', 'space')
  }

  if (core.button('throw', 'Throw', w - 58, h - 160, 48, 48).clicked) {
    love.event.push('keypressed', 'j')
  }

  if (core.button('util', 'Util', w - 160, h - 160, 48, 48).clicked) {
    love.event.push('keypressed', 'u')
  }

  if (core.button('dash', 'Dash', w - 160, h - 58, 48, 48).clicked) {
    love.event.push('keypressed', 'k')
  }

  if (core.button('pause', 'Pause', w - 310, 10, 300, 30).clicked) {
    game.setState(State.PAUSED)
  }
}

export const draw = (core: GuiCore, game: Game) => {
  const abilities = game.player.as(Abilities)

  if (abilities) {
    drawCooldowns(abilities)
  }
}

// local function money(player)
//   local label = 'Money: ' .. tostring(player:as(Player).money)
//   love.graphics.print(label, 10, 10, 0)
// end

// local function lives(player)
//   local label = 'Lives: ' .. tostring(player:as(Player).lives)
//   love.graphics.print(label, 10, 30, 0)
// end

// local function documents(player)
//   local label = 'Documents: ' .. tostring(player:as(Player).documents)
//   love.graphics.print(label, 10, 50, 0)
// end

// local function getPercent(player, key)
//   local ability = player:as(Ability).abilities[key]
//   local total = ability.cooldown or 0
//   local current = total - ((ability.timers.cooldown or {}).running or 0)

//   return (total - current) / total
// end

// local function cooldowns(player)
//   love.graphics.setColor(0, 0, 0, 0.5)
//   arc(width - 24 - 10, height - 64 - 24 - 48, getPercent(player, 'throw'))
//   arc(width - 64 - 24 - 48, height - 24 - 10, getPercent(player, 'dash'))
//   love.graphics.setColor(255, 255, 255)
// end

// function Playing.update(dt, suit, player, game)
//   if suit.Button('Jump', (width - 64) - 10, height - 64 - 10, 64, 64).hit then
//     keypressed('space')
//   end

//   if suit.Button('Throw', width - 48 - 10, height - 64 - 48 - 48, 48, 48).hit then
//     keypressed('j')
//   end

//   if
//     suit.Button('Util', width - 64 - 48 - 48, height - 64 - 48 - 48, 48, 48).hit
//    then
//   -- keypressed('k')
//   end

//   if suit.Button('Dash', width - 64 - 48 - 48, height - 48 - 10, 48, 48).hit then
//     keypressed('k')
//   end

//   if suit.Button('Pause', (width - 300) - 10, 10, 300, 30).hit then
//     game:setState(State.PAUSED)
//   end
// end

// function Playing.draw(player, game)
//   money(player)
//   lives(player)
//   documents(player)

//   if (player:has(Ability)) then
//     cooldowns(player)
//   end
// end

// return Playing
