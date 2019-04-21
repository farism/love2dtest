// local constants = require 'src.game.components.constants'

// local Animation = {
//   _meta = constants.Animation
// }

// local function buildFrames(width, height, animation)
//   local frames = {}

//   for step = 1, animation.length do
//     table.insert(
//       frames,
//       love.graphics.newQuad(
//         animation.x + (step - 1) * animation.width,
//         animation.y,
//         animation.width,
//         animation.height,
//         width,
//         height
//       )
//     )
//   end

//   return frames
// end

// function Animation.new(id, currentAnimation, animations, width, height)
//   animations = animations or {}

//   for _, animation in pairs(animations) do
//     animation.frames = buildFrames(width, height, animation)
//     animation.step = animation.duration / animation.length
//   end

//   return {
//     _meta = Animation._meta,
//     id = id,
//     elapsedTime = 0,
//     currentFrame = 1,
//     currentAnimation = currentAnimation,
//     animations = animations
//   }
// end

// return Animation
