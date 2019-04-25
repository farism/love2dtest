// local Aspect = require 'src.ecs.aspect'
// local System = require 'src.ecs.system'
// local State = require 'src.game.state'
// local Player = require 'src.game.components.player'

// local aspect = Aspect.new({Player})
// local GameOver = System:new('gameover', aspect)

// function GameOver:update(dt)
//   for _, entity in pairs(self.entities) do
//     local player = entity:as(Player)

//     if (player.lives == 0) then
//       game:setState(State.GAMEOVER)
//     end
//   end
// end

// return GameOver
