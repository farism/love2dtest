local cron = require 'vendor.cron'
local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Fixture = require 'game.components.fixture'
local Platform = require 'game.components.platform'
local Player = require 'game.components.player'
local Position = require 'game.components.position'
local Waypoint = require 'game.components.waypoint'
local collision = require 'game.utils.collision'

local aspect = Aspect.new({Fixture, Platform})
local PlatformSystem = System:new('fall', aspect)

local function reset(entity)
  local body = entity:as(Fixture).fixture:getBody()
  local platform = entity:as(Platform) or {}
  local waypoint = entity:as(Waypoint) or {}

  return function()
    body:setType('static')
    body:setPosition(platform.initialX, platform.initialY)
    body:setGravityScale(0)
    body:setType('kinematic')
    waypoint.active = true
    platform.timeout = nil
  end
end

local function startFalling(entity)
  local body = entity:as(Fixture).fixture:getBody()
  local platform = entity:as(Platform)
  local waypoint = entity:as(Waypoint) or {}

  return function()
    body:setType('dynamic')
    body:setGravityScale(1)
    waypoint.active = false
    platform.timeout = cron.after(3, reset(entity))
  end
end

local function fall(entity)
  local platform = entity:as(Platform)

  if (platform.fall or 0) > 0 and not platform.timeout then
    local x, y = entity:as(Position):coords()
    platform.initialX = x
    platform.initialY = y
    platform.timeout = cron.after(platform.fall, startFalling(entity))
  end
end

function PlatformSystem:update(dt)
  for _, entity in pairs(self.entities) do
    local platform = entity:as(Platform)

    if platform.timeout then
      platform.timeout:update(dt)
    end
  end
end

function PlatformSystem:beginContact(a, b, contact)
  a = collision.entity(a)
  b = collision.entity(b)

  if a:has(Platform) and b:has(Player) then
    fall(a)
  elseif b:has(Platform) and a:has(Player) then
    fall(b)
  end
end

return PlatformSystem
