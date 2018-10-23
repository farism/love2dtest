local Aspect = require('ecs/Aspect')
local System = require('ecs/System')
local Projectile = require('game/components/Projectile')
local constants = require('game/systems/constants')

local ProjectileSystem = {
  _meta = constants.Projectile
}

local function noop()
end

local function update(dt, entities)
  -- print('projectile update ', table.getn(entities))
end

function ProjectileSystem:new(world)
  local aspect = Aspect:new({Projectile})
  local system = System:new('projectile', aspect, noop, update, noop)

  return system
end

return ProjectileSystem
