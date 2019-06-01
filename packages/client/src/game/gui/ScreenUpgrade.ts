import { Entity } from '../../ecs/Entity'
import { State } from '../State'
import { GuiCore } from './GuiCore'

interface Game {
  player: Entity
  state: State
  setState: (state: State) => void
}

export const update = (core: GuiCore, game: Game) => {}

export const draw = (core: GuiCore, game: Game) => {}
