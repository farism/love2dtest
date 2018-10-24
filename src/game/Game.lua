local Manager = require 'ecs.manager'

local Prefabs = require 'game.prefabs'
local HUD = require 'game.hud.hud'
local Input = require 'game.systems.input'
local Logger = require 'game.systems.logger'
local Movement = require 'game.systems.movement'
local Projectile = require 'game.systems.projectile'
local FixtureRender = require 'game.systems.fixturerender'
local SpriteRender = require 'game.systems.spriterender'

local Game = {}

local function initEntities(manager, world)
  local pf = Prefabs(world)
  local arr = {pf.player(), pf.ground()}

  for _, prefab in pairs(arr) do
    local e = manager:newEntity()

    for _, component in pairs(prefab) do
      manager:addComponent(e, component)
    end
  end
end

function Game:new()
  local game = {
    hud = HUD:new(),
    manager = Manager:new(),
    world = love.physics.newWorld(0, 9.81, true)
  }

  game.manager:addSystem(InputSystem)
  game.manager:addSystem(Logger)
  game.manager:addSystem(Movement)
  game.manager:addSystem(Projectile)
  game.manager:addSystem(FixtureRender)
  game.manager:addSystem(SpriteRender)

  initEntities(game.manager, game.world)

  function game:input(key, scancode, isRepeat, isPressed)
    self.manager:input(key, scancode, isRepeat, isPressed)
  end

  function game:update(dt)
    self.world:update(dt)
    self.manager:update(dt)
    self.hud:update(dt)
  end

  function game:draw()
    self.manager:draw()
    self.hud:draw()
  end

  return game
end

return Game

-- local function resetJumps(a, b, contact)
--   local aData = a:getUserData()
--   local bData = b:getUserData()
--   local entity = nil

--   if (aData.isPlayer and b:getBody():getType() == Fixture.STATIC) then
--     entity = aData.entity
--   elseif (bData.isPlayer and a:getBody():getType() == Fixture.STATIC) then
--     entity = bData.entity
--   end

--   if entity then
--     entity:as(Input).jumps = 0
--   end
-- end
