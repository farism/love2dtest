import { Entity } from '../../ecs/Entity'
import { State } from '../State'
import { GuiCore } from './GuiCore'

interface Game {
  player: Entity
  state: State
  setState: (state: State) => void
}

const [w, h] = love.graphics.getDimensions()

export const update = (core: GuiCore, game: Game) => {
  if (core.button('resume', 'Resume', (w - 310) / 2, 10, 300, 30).clicked) {
    game.setState(State.PLAYING)
  }

  if (core.button('restart', 'Restart', (w - 310) / 2, 60, 300, 30).clicked) {
    game.setState(State.PLAYING)
  }

  if (core.button('home', 'Home', (w - 310) / 2, 110, 300, 30).clicked) {
    game.setState(State.HOME)
  }
}

export const draw = (core: GuiCore, game: Game) => {}
