// local cron = require 'src.vendor.cron'
// local Aspect = require 'src.ecs.aspect'
// local System = require 'src.ecs.system'
// local Checkpoint = require 'src.game.components.checkpoint'
// local Fixture = require 'src.game.components.fixture'
// local Player = require 'src.game.components.player'
// local Position = require 'src.game.components.position'
// local Respawn = require 'src.game.components.respawn'

// local aspect = Aspect.new({Respawn})
// local RespawnSystem = System:new('respawn', aspect)

// function findCheckpoint(entity)
//   local player = entity:as(Player)
//   local fixture = entity:as(Fixture)

//   for _, entity in pairs(entity.manager.entities) do
//     local checkpoint = entity:as(Checkpoint)

//     if checkpoint and player.checkpoint == checkpoint.index then
//       return entity
//     end
//   end
// end

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
