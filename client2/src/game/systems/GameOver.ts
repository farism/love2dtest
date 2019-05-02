import { System } from '../../ecs/System'
import { SystemFlag } from '../flags'
import { Aspect } from '../../ecs/Aspect'
import { Player } from '../components/Player'
import { State } from '../State'

export class GameOverSystem extends System {
  static _id = 'GameOver'
  _id = GameOverSystem._id

  static _flag = SystemFlag.GameOver
  _flag = GameOverSystem._flag

  static _aspect = new Aspect([Player])
  _aspect = GameOverSystem._aspect

  update = (dt: number) => {
    this.entities.forEach(entity => {
      const player = entity.as(Player)

      if (player && player.lives === 0) {
        // game.setState(State.GAMEOVER)
      }
    })
  }
}
