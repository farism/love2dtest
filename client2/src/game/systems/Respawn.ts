import { System } from '../../ecs/System'
import { Manager } from '../../ecs/manager'
import { SystemFlag } from '../flags'
import { Aspect } from '../../ecs/Aspect'
import { Player } from '../components/Player'
import { Respawn } from '../components/Respawn'
import { Checkpoint } from '../components/Checkpoint'

const findCheckpoint = (index: number, manager: Manager) => {
  let entity

  manager.entities.forEach(entity => {
    const checkpoint = entity.as(Checkpoint)

    if (checkpoint && checkpoint.index) {
      entity = entity
    }
  })

  return entity
}

export class RespawnSystem extends System {
  static _id = 'Respawn'
  _id = RespawnSystem._id

  static _flag = SystemFlag.Respawn
  _flag = RespawnSystem._flag

  static _aspect = new Aspect([Respawn])
  _aspect = RespawnSystem._aspect

  update = (dt: number) => {
    this.entities.forEach(entity => {
      const player = entity.as(Player)
      const respawn = entity.as(Respawn)

      if (player && respawn) {
        if (respawn.waitTime) {
        }
      }
    })
  }
}

// local function resetPosition(entity)
//   return function()
//     local respawn = entity:as(Respawn)
//     respawn.timeout = nil

//     local checkpoint = findCheckpoint(entity)
//     if checkpoint then
//       local fixture = entity:as(Fixture)
//       local body = fixture.fixture:getBody()
//       local position = checkpoint:as(Position)

//       body:setType('static')
//       body:setPosition(position.x, position.y)
//       body:setType('dynamic')
//     end

//     entity:remove(Respawn)
//   end
// end

// function RespawnSystem:update(dt)
//   for _, entity in pairs(self.entities) do
//     local player = entity:as(Player)
//     local respawn = entity:as(Respawn)

//     if respawn.timeout then
//       respawn.timeout:update(dt)
//     else
//       -- player.lives = math.max(0, player.lives - 1)
//       respawn.timeout = cron.after(respawn.waitTime, resetPosition(entity))
//     end
//   end
// end

// return RespawnSystem
