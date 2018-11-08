local Collision = {}

function Collision.entity(fixture)
  return fixture:getUserData().entity
end

function Collision.is(type, fixture)
  return Collision.entity(fixture).meta.type == type
end

function Collision.as(component, fixture)
  return Collision.entity(fixture):as(component)
end

function Collision.isNotDynamic(fixture)
  return fixture:getBody():getType() ~= 'dynamic'
end

function Collision.isAggression(fixture)
  return fixture:getUserData().aggression
end

return Collision
