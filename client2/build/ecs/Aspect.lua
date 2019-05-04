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
local __TSTL_Component = require("ecs.Component")
local Component = __TSTL_Component.Component
local __TSTL_Entity = require("ecs.Entity")
local Entity = __TSTL_Entity.Entity
local flags
flags = function(____, components)
    local flags = 0
    __TS__ArrayForEach(components, function(____, cmp)
        flags = bit.bxor(flags, cmp._flag)
    end)
    return flags
end
____exports.Aspect = {}
local Aspect = ____exports.Aspect
Aspect.name = "Aspect"
Aspect.__index = Aspect
Aspect.prototype = {}
Aspect.prototype.__index = Aspect.prototype
Aspect.prototype.constructor = Aspect
function Aspect.new(...)
    local self = setmetatable({}, Aspect.prototype)
    self:____constructor(...)
    return self
end
function Aspect.prototype.____constructor(self, all, none, one)
    self.check = function(____, entity)
        local all = bit.bor(self.all, entity.components) == entity.components
        local none = bit.band(self.none, entity.components) == 0
        local one = bit.band(self.one, entity.components) ~= 0
        return (one or all) and none
    end
    if all == nil then
        all = {}
    end
    if none == nil then
        none = {}
    end
    if one == nil then
        one = {}
    end
    self.all = flags(nil, all)
    self.none = flags(nil, none)
    self.one = flags(nil, one)
end
____exports.AlwaysAspect = {}
local AlwaysAspect = ____exports.AlwaysAspect
AlwaysAspect.name = "AlwaysAspect"
AlwaysAspect.__index = AlwaysAspect
AlwaysAspect.prototype = {}
AlwaysAspect.prototype.__index = AlwaysAspect.prototype
AlwaysAspect.prototype.constructor = AlwaysAspect
AlwaysAspect.____super = Aspect
setmetatable(AlwaysAspect, AlwaysAspect.____super)
setmetatable(AlwaysAspect.prototype, AlwaysAspect.____super.prototype)
function AlwaysAspect.new(...)
    local self = setmetatable({}, AlwaysAspect.prototype)
    self:____constructor(...)
    return self
end
function AlwaysAspect.prototype.____constructor(self, ...)
    Aspect.prototype.____constructor(self, ...)
    self.check = function(____, _)
        return true
    end
end
____exports.NeverAspect = {}
local NeverAspect = ____exports.NeverAspect
NeverAspect.name = "NeverAspect"
NeverAspect.__index = NeverAspect
NeverAspect.prototype = {}
NeverAspect.prototype.__index = NeverAspect.prototype
NeverAspect.prototype.constructor = NeverAspect
NeverAspect.____super = Aspect
setmetatable(NeverAspect, NeverAspect.____super)
setmetatable(NeverAspect.prototype, NeverAspect.____super.prototype)
function NeverAspect.new(...)
    local self = setmetatable({}, NeverAspect.prototype)
    self:____constructor(...)
    return self
end
function NeverAspect.prototype.____constructor(self, ...)
    Aspect.prototype.____constructor(self, ...)
    self.check = function(____, _)
        return false
    end
end
return ____exports
