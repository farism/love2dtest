--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_Entity = require("ecs.Entity");
local Entity = __TSTL_Entity.Entity;
local __TSTL_component = require("ecs.component");
local Component = __TSTL_component.Component;
local noop;
noop = function(____)
end;
exports.getEntity = function(____, fixture)
    return fixture:getUserData().entity;
end;
exports.hasComponent = function(____, component)
    return function(____, fixture)
        return exports.getEntity(nil, fixture):has(component);
    end;
end;
exports.isBodyType = function(____, type)
    return function(____, fixture)
        return fixture:getBody():getType() == type;
    end;
end;
exports.isNotBodyType = function(____, type)
    return function(____, fixture)
        return not exports.isBodyType(nil, type)(nil, fixture);
    end;
end;
exports.isSensor = function(____, fixture)
    return fixture:isSensor();
end;
exports.isNotSensor = function(____, fixture)
    return not exports.isSensor(nil, fixture);
end;
exports.check = function(____, a, b, checks)
    local check1;
    check1 = checks[0 + 1] or noop;
    local check2;
    check2 = checks[1 + 1] or noop;
    if check1(nil, a) and check2(nil, b) then
        return {exports.getEntity(nil, a), exports.getEntity(nil, b)};
    elseif check1(nil, b) and check2(nil, a) then
        return {exports.getEntity(nil, b), exports.getEntity(nil, a)};
    end
    return nil;
end;
return exports;
