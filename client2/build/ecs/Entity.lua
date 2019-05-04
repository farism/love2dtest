--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
-- Lua Library inline imports
function __TS__ArrayForEach(arr, callbackFn)
    do
        local i = 0
        while i < #arr do
            callbackFn(_G, arr[i + 1], i, arr)
            i = i + 1
        end
    end
end

local ____exports = {}
local __TSTL_component = require("ecs.component")
local Component = __TSTL_component.Component
local __TSTL_types = require("ecs.types")
local Aliasable = __TSTL_types.Aliasable
____exports.Entity = {}
local Entity = ____exports.Entity
Entity.name = "Entity"
Entity.__index = Entity
Entity.prototype = {}
Entity.prototype.__index = Entity.prototype
Entity.prototype.constructor = Entity
function Entity.new(...)
    local self = setmetatable({}, Entity.prototype)
    self:____constructor(...)
    return self
end
function Entity.prototype.____constructor(self, id, manager, userData)
    self.add = function(____, component)
        self.manager:addComponent(self, component)
    end
    self.addAll = function(____, components)
        __TS__ArrayForEach(components, function(____, component) return self:add(component) end)
    end
    self.as = function(____, Class)
        local cmp = self.manager:getComponent(self, Class)
        return cmp and cmp
    end
    self.clearFlag = function(____, component)
        self.components = bit.band(self.components, bit.bnot(component._flag))
    end
    self.destroy = function()
        self.manager:removeEntity(self)
    end
    self.has = function(____, component)
        return bit.band(self.components, component._flag) == component._flag
    end
    self.remove = function(____, component)
        self.manager:removeComponent(self, component)
    end
    self.setFlag = function(____, component)
        self.components = bit.bxor(self.components, component._flag)
    end
    if userData == nil then
        userData = {}
    end
    self.components = 0
    self.id = id
    self.manager = manager
    self.systems = 0
    self.userData = userData
end
return ____exports
