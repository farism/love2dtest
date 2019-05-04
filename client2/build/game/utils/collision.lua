--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
-- Lua Library inline imports
function __TS__ArrayEvery(arr, callbackfn)
    do
        local i = 0
        while i < #arr do
            if not callbackfn(_G, arr[i + 1], i, arr) then
                return false
            end
            i = i + 1
        end
    end
    return true
end

local ____exports = {}
local __TSTL_Entity = require("ecs.Entity")
local Entity = __TSTL_Entity.Entity
local __TSTL_component = require("ecs.component")
local Component = __TSTL_component.Component
local noop
noop = function()
end
____exports.getEntity = function(____, fixture)
    return fixture:getUserData().entity
end
____exports.hasComponent = function(____, component) return function(____, fixture)
    return ____exports.getEntity(nil, fixture):has(component)
end end
____exports.hasComponents = function(____, ...)
    local components = ({...})
    return function(____, fixture)
        return __TS__ArrayEvery(components, function(____, component) return ____exports.hasComponent(nil, component)(nil, fixture) end)
    end
end
____exports.isBodyType = function(____, type) return function(____, fixture)
    return fixture:getBody():getType() == type
end end
____exports.isNotBodyType = function(____, type) return function(____, fixture)
    return not ____exports.isBodyType(nil, type)(nil, fixture)
end end
____exports.isSensor = function(____, fixture)
    return fixture:isSensor()
end
____exports.isNotSensor = function(____, fixture)
    return not ____exports.isSensor(nil, fixture)
end
____exports.check = function(____, a, b, checks)
    local check1
    check1 = checks[0 + 1] or noop
    local check2
    check2 = checks[1 + 1] or noop
    if check1(nil, a) and check2(nil, b) then
        return {
            ____exports.getEntity(nil, a),
            ____exports.getEntity(nil, b),
        }
    elseif check1(nil, b) and check2(nil, a) then
        return {
            ____exports.getEntity(nil, b),
            ____exports.getEntity(nil, a),
        }
    end
    return nil
end
return ____exports
