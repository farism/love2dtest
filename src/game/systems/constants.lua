local flag = require 'game.utils.flag'

local constants = {}

constants = {
  Logger = {id = 'logger', flag = flag(0)},
  Movement = {id = 'movement', flag = flag(1)},
  Projectile = {id = 'projectile', flag = flag(2)},
  FixtureRender = {id = 'fixture_render', flag = flag(3)},
  SpriteRender = {id = 'sprite_render', flag = flag(4)},
  ControlMovement = {id = 'control_movement', flag = flag(5)}
}

return constants
