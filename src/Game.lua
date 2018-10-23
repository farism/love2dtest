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
local FixtureRenderSystem = require 'game/systems/FixtureRender'
local SpriteRenderSystem = require 'game/systems/SpriteRender'

local world = nil
local manager = nil

local function resetJumps(a, b, contact)
  local aData = a:getUserData()
  local bData = b:getUserData()
  local entity = nil

  if (aData.isPlayer and b:getBody():getType() == Fixture.STATIC) then
    entity = aData.entity
  elseif (bData.isPlayer and a:getBody():getType() == Fixture.STATIC) then
    entity = bData.entity
  end

  if entity then
    entity:as(Input).jumps = 0
  end
end

local function newWorld(meter, manager)
  love.physics.setMeter(meter)

  local world = love.physics.newWorld(0, 9.81 * meter, true)
  world.setCallbacks(world, resetJumps)

  return world
end

function love.load()
  love.graphics.setBackgroundColor(0.41, 0.53, 0.97)

  world = newWorld(100)

  manager = Manager:new()
  manager:addSystem(InputSystem:new())
  manager:addSystem(LoggerSystem:new())
  manager:addSystem(MovementSystem:new())
  manager:addSystem(ProjectileSystem:new())
  manager:addSystem(FixtureRenderSystem:new())
  manager:addSystem(SpriteRenderSystem:new())

  local player = manager:newEntity()
  manager:addComponent(player, Input:new(1))
  manager:addComponent(player, Sprite:new(1, 'assets/sprites/player.png'))
  manager:addComponent(player, Position:new(1))
  manager:addComponent(player, Velocity:new(1))
  manager:addComponent(
    player,
    Fixture:new(
      1,
      {isPlayer = true, entity = player},
      {world, 0, 0, Fixture.DYNAMIC},
      {Fixture.RECTANGLE, 32, 32},
      1
    )
  )

  local ground = manager:newEntity()
  manager:addComponent(
    ground,
    Fixture:new(
      1,
      {},
      {world, 800 / 2, 480 - 15, Fixture.STATIC},
      {Fixture.RECTANGLE, 800, 30}
    )
  )
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
