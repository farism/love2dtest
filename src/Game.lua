local sleep = require 'utils/sleep'

local Manager = require 'ecs/Manager'
local Entity = require 'ecs/Entity'
local Aspect = require 'ecs/Aspect'

local Fixture = require 'game/components/Fixture'
local Input = require 'game/components/Input'
local Player = require 'game/components/Player'
local Position = require 'game/components/Position'
local Sprite = require 'game/components/Sprite'
local Spritesheet = require 'game/components/Spritesheet'
local Velocity = require 'game/components/Velocity'

local InputSystem = require 'game/systems/Input'
local LoggerSystem = require 'game/systems/Logger'
local MovementSystem = require 'game/systems/Movement'
local ProjectileSystem = require 'game/systems/Projectile'
local SpriteSystem = require 'game/systems/Sprite'

local world = nil
local manager = nil

local function newWorld(meter)
  love.physics.setMeter(meter)

  return love.physics.newWorld(0, 9.81 * meter, true)
end

function love.load()
  world = newWorld(100)

  manager = Manager:new()
  manager:addSystem(InputSystem:new())
  manager:addSystem(LoggerSystem:new())
  manager:addSystem(MovementSystem:new())
  manager:addSystem(ProjectileSystem:new())
  manager:addSystem(SpriteSystem:new())

  local player = manager:newEntity()
  manager:addComponent(player, Input:new(1))
  manager:addComponent(player, Sprite:new(1, 'assets/sprites/player.png'))
  manager:addComponent(player, Position:new(1))
  manager:addComponent(player, Velocity:new(1))
  manager:addComponent(
    player,
    Fixture:new(1, {world, 0, 0, Fixture.DYNAMIC}, {Fixture.RECTANGLE, 32, 32})
  )

  love.graphics.setBackgroundColor(0.41, 0.53, 0.97)
end

function love.update(dt)
  world:update(dt)
  manager:update(dt)
end

function love.draw()
  manager:draw()
end

function love.keypressed(key, scancode, isRepeat)
  manager:input(key, scancode, isRepeat, true)
end

function love.keyreleased(key, scancode)
  manager:input(key, scancode, false, false)
end

-- function getPlayerContact(a, b)
--   local aData = a:getUserData() or {}
--   local bData = b:getUserData() or {}

--   if (aData.player) then
--     return a
--   elseif (bData.player) then
--     return b
--   end
-- end

-- function beginContact(a, b, coll)
--   local player = getPlayerContact(a, b, coll)

--   if player then
--     Player.jumpReset(state.player)
--   end
-- end
