import { Entity } from '../../ecs/Entity'
import { State } from '../State'
import * as stats from './stats'
import { UI } from '../utils/ui'

export class HUD {
  player: Entity
  state: State
  ui: UI

  constructor(player: Entity, state: State, ui: UI) {
    this.player = player
    this.state = state
    this.ui = ui
  }

  update = (dt: number) => {}

  draw = () => {
    // fps and stats
    stats.draw()
    this.ui.button({ x: 0, y: 0, width: 200, height: 50, text: 'Click me!' })
    this.ui.draw()

    // suit ui

    // additional drawing
  }
}
