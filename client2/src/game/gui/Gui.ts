import { Entity } from '../../ecs/Entity'
import { State } from '../State'
import { GuiCore } from './GuiCore'
import * as ScreenHome from './ScreenHome'
import * as ScreenPaused from './ScreenPaused'
import * as ScreenPlaying from './ScreenPlaying'
import * as stats from './stats'

interface Game {
  player: Entity
  state: State
  setState: (state: State) => void
}

interface Screen {
  draw: (core: GuiCore, game: Game) => void
  update: (core: GuiCore, game: Game) => void
}

const screens: { [key in State]: Screen } = {
  gameover: ScreenPlaying,
  home: ScreenHome,
  paused: ScreenPaused,
  playing: ScreenPlaying,
  upgrades: ScreenPlaying,
}

export class Gui {
  core: GuiCore
  player: Entity

  constructor(player: Entity) {
    this.core = new GuiCore()
    this.player = player
  }

  update = (dt: number, game: Game) => {
    const screen = screens[game.state]

    screen.update(this.core, game)
  }

  draw = (game: Game) => {
    this.core.draw()

    const screen = screens[game.state]
    screen.draw(this.core, game)

    stats.draw()
  }
}
