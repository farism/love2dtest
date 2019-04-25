// local Aspect = require 'src.ecs.aspect'
// local System = require 'src.ecs.system'
// local Fixture = require 'src.game.components.fixture'
// local Health = require 'src.game.components.health'
// local Player = require 'src.game.components.player'
// local Respawn = require 'src.game.components.respawn'

// local aspect = Aspect.new({Health})
// local Death = System:new('death', aspect)

// local function destroyJoints(entity)
//   local fixture = entity:as(Fixture)
//   local joints = fixture.fixture:getBody():getJoints()
//   for _, joint in pairs(joints) do
//     local a, b = joint:getBodies()
//     a:getUserData().entity:destroy()
//     b:getUserData().entity:destroy()
//   end
// end

// function Death:container(dt, entity)
//   entity:destroy()
// end

// function Death:mob(dt, entity)
//   destroyJoints(entity)
//   entity:destroy()
// end

// function Death:player(dt, entity)
//   local health = entity:as(Health)
//   local player = entity:as(Player)

//   entity:add(Respawn.new(1))
//   health.hitpoints = 1
// end

// function Death:update(dt)
//   for _, entity in pairs(self.entities) do
//     local health = entity:as(Health)

//     if (health.hitpoints <= 0) then
//       local fn = self[entity.meta.type]

//       if (fn) then
//         fn(self, dt, entity)
//       end
//     end
//   end
// end

// return Death
