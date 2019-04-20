local Collision = {}

function noop()
end

function Collision.check(a, b, checks)
  local check1 = checks[1] or noop
  local check2 = checks[2] or noop

  if check1(a) and check2(b) then
    return {Collision.entity(a), Collision.entity(b)}
  elseif check1(b) and check2(a) then
    return {Collision.entity(b), Collision.entity(a)}
  end

  return false
end

function Collision.entity(fixture)
  return fixture:getUserData().entity
end

function Collision.is(type, fixture)
  return Collision.entity(fixture).meta.type == type
end

function Collision.hasComponent(component)
  return function(fixture)
    return Collision.entity(fixture):has(component)
  end
end

function Collision.as(component, fixture)
  return Collision.entity(fixture):as(component)
end

function Collision.isNotDynamic(fixture)
  return fixture:getBody():getType() ~= 'dynamic'
end

function Collision.isBodyType(type)
  return function(fixture)
    return fixture:getBody():getType() == type
  end
end

function Collision.isNotBodyType(type)
  return function(fixture)
    return fixture:getBody():getType() ~= type
  end
end

function Collision.isAggression(fixture)
  return fixture:getUserData().aggression
end

return Collision
