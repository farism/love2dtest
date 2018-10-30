local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Projectile = require 'game.components.projectile'

local aspect = Aspect:new({Projectile})
local ProjectileSystem = System:new('projectile', aspect)

local function isThrowingPick(fixture)
  return fixture:getUserData().type == 'throwingPick'
end

local function isCrate(fixture)
  return fixture:getUserData().type == 'crate'
end

local function check(a, b)
  return isThrowingPick(a) and isCrate(b)
end

function ProjectileSystem:collision(a, b, contact)
  if check(a, b) or check(b, a) then
    self.manager:removeEntity(a:getUserData().entity)
    self.manager:removeEntity(b:getUserData().entity)
  end
end

return ProjectileSystem
