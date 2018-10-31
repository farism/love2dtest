local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'

local DamageSystem = System:new('damage')

local destroyOnContact = {'throwingPick'}

local function destroy(type, fixture)
  if fixture:getUserData().type == type then
    fixture:getUserData().entity:destroy()
    fixture:getBody():destroy()

    return true
  end

  return false
end

function DamageSystem:collision(a, b, contact)
  local isProjectileCollision =
    destroy('throwingPick', a) or destroy('throwingPick', b)

  if isProjectileCollision then
    destroy('container', a)
    destroy('container', b)
  end
end

return DamageSystem
