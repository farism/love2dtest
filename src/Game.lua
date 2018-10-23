local sleep = require 'utils/sleep'

local Manager = require 'ecs/Manager'
local Entity = require 'ecs/Entity'
local Aspect = require 'ecs/Aspect'

local Movement = require 'game/components/Movement'
local Player = require 'game/components/Player'
local Sprite = require 'game/components/Sprite'
local Spritesheet = require 'game/components/Spritesheet'

local LoggerSystem = require 'game/systems/Logger'
local MovementSystem = require 'game/systems/Movement'
local ProjectileSystem = require 'game/systems/Projectile'
local SpriteSystem = require 'game/systems/Sprite'

local manager = Manager:new()

local function newWorld(meter)
  love.physics.setMeter(meter)

  return love.physics.newWorld(0, 9.81 * meter, true)
end

function love.load()
  local world = newWorld(100)

  manager:addSystem(MovementSystem:new(world))
  manager:addSystem(LoggerSystem:new())
  manager:addSystem(ProjectileSystem:new(world))
  manager:addSystem(SpriteSystem:new())

  local player = manager:newEntity()
  manager:addComponent(player, Movement:new(1))
  manager:addComponent(player, Sprite:new(1, 'assets/sprites/player.png'))

  local mob = manager:newEntity()

  love.graphics.setBackgroundColor(0.41, 0.53, 0.97)
end

function love.update(dt)
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

-- local state = {}
-- local world = nil

-- function love.load()
--
--

--   state.ground = Ground.create(world)
--   state.wall = Wall.create(world)
--   state.player = Player.create(world)
-- end

-- function love.keypressed(key, scancode, isRepeat)
--   if key == 'space' and not isrepeat then
--     Player.jump(state.player)
--   end
-- end

-- function love.update(dt)
--   world:update(dt)
--   Ground.update(state.ground, dt)
--   Wall.update(state.wall, dt)
--   Player.update(state.player, dt)
-- end

-- function love.draw()
--   Ground.draw(state.ground)
--   Wall.draw(state.wall)
--   Player.draw(state.player)
-- end

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
