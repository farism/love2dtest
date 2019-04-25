// local Aspect = require 'src.ecs.aspect'
// local System = require 'src.ecs.system'
// local Animation = require 'src.game.components.animation'
// local Movement = require 'src.game.components.movement'

// local aspect = Aspect.new({Animation, Movement})
// local SetCurrentAnimation = System:new('setcurrentanimation', aspect)

// function SetCurrentAnimation:update(dt)
//   for _, entity in pairs(self.entities) do
//     local animation = entity:as(Animation)
//     local movement = entity:as(Movement)

//     local action = 'stand'

//     if movement.right or movement.left then
//       action = 'walk'
//     end

//     local newAnimation = action .. '_' .. movement.direction

//     if newAnimation ~= animation.currentAnimation then
//       animation.currentAnimation = newAnimation
//       animation.currentFrame = 1
//     end
//   end
// end

// return SetCurrentAnimation
