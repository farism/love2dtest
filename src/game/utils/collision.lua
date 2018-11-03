local Collision = {}

function Collision.isType(type, fixture)
  return fixture:getUserData().entity.meta.type == type
end

function Collision.isNotDynamic(fixture)
  return fixture:getBody():getType() ~= 'dynamic'
end

return Collision
