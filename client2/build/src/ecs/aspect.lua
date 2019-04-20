--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
-- Lua Library inline imports
__TS__ArrayForEach = function(arr, callbackFn)
    do
        local i = 0;
        while i < (#arr) do
            callbackFn(_G, arr[i + 1], i, arr);
            i = i + 1;
        end
    end
end;

local exports = exports or {};
local __TSTL_Component = require("src.ecs.Component");
local Component = __TSTL_Component.Component;
local __TSTL_Entity = require("src.ecs.Entity");
local Entity = __TSTL_Entity.Entity;
local flags;
flags = function(____, components)
    local flags = 0;
    __TS__ArrayForEach(components, function(____, cmp)
        flags = bit.bxor(flags, cmp._flag);
    end);
    return flags;
end;
exports.Aspect = exports.Aspect or {};
exports.Aspect.__index = exports.Aspect;
exports.Aspect.prototype = exports.Aspect.prototype or {};
exports.Aspect.prototype.__index = exports.Aspect.prototype;
exports.Aspect.prototype.constructor = exports.Aspect;
exports.Aspect.new = function(...)
    local self = setmetatable({}, exports.Aspect.prototype);
    self:____constructor(...);
    return self;
end;
exports.Aspect.prototype.____constructor = function(self, all, none, one)
    self.check = function(____, entity)
        local all = bit.bor(self.all, entity.components) == entity.components;
        local none = bit.band(self.none, entity.components) == 0;
        local one = bit.band(self.one, entity.components) ~= 0;
        return (one or all) and none;
    end;
    if all == nil then
        all = {};
    end
    if none == nil then
        none = {};
    end
    if one == nil then
        one = {};
    end
    self.all = flags(nil, all);
    self.none = flags(nil, none);
    self.one = flags(nil, one);
end;
exports.AlwaysAspect = exports.AlwaysAspect or {};
exports.AlwaysAspect.__index = exports.AlwaysAspect;
exports.AlwaysAspect.prototype = exports.AlwaysAspect.prototype or {};
exports.AlwaysAspect.prototype.__index = exports.AlwaysAspect.prototype;
exports.AlwaysAspect.prototype.constructor = exports.AlwaysAspect;
exports.AlwaysAspect.____super = exports.Aspect;
setmetatable(exports.AlwaysAspect, exports.AlwaysAspect.____super);
setmetatable(exports.AlwaysAspect.prototype, exports.AlwaysAspect.____super.prototype);
exports.AlwaysAspect.new = function(...)
    local self = setmetatable({}, exports.AlwaysAspect.prototype);
    self:____constructor(...);
    return self;
end;
exports.AlwaysAspect.prototype.____constructor = function(self, ...)
    exports.Aspect.prototype.____constructor(self, ...);
    self.check = function(____, _)
        return true;
    end;
end;
exports.NeverAspect = exports.NeverAspect or {};
exports.NeverAspect.__index = exports.NeverAspect;
exports.NeverAspect.prototype = exports.NeverAspect.prototype or {};
exports.NeverAspect.prototype.__index = exports.NeverAspect.prototype;
exports.NeverAspect.prototype.constructor = exports.NeverAspect;
exports.NeverAspect.____super = exports.Aspect;
setmetatable(exports.NeverAspect, exports.NeverAspect.____super);
setmetatable(exports.NeverAspect.prototype, exports.NeverAspect.____super.prototype);
exports.NeverAspect.new = function(...)
    local self = setmetatable({}, exports.NeverAspect.prototype);
    self:____constructor(...);
    return self;
end;
exports.NeverAspect.prototype.____constructor = function(self, ...)
    exports.Aspect.prototype.____constructor(self, ...);
    self.check = function(____, _)
        return false;
    end;
end;
return exports;
