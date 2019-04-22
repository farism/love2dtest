--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_Aspect = require("ecs.Aspect");
local Aspect = __TSTL_Aspect.Aspect;
local __TSTL_System = require("ecs.System");
local System = __TSTL_System.System;
exports.IntervalSystem = exports.IntervalSystem or {};
exports.IntervalSystem.__index = exports.IntervalSystem;
exports.IntervalSystem.prototype = exports.IntervalSystem.prototype or {};
exports.IntervalSystem.prototype.__index = exports.IntervalSystem.prototype;
exports.IntervalSystem.prototype.constructor = exports.IntervalSystem;
exports.IntervalSystem.____super = System;
setmetatable(exports.IntervalSystem, exports.IntervalSystem.____super);
setmetatable(exports.IntervalSystem.prototype, exports.IntervalSystem.____super.prototype);
exports.IntervalSystem.new = function(...)
    local self = setmetatable({}, exports.IntervalSystem.prototype);
    self:____constructor(...);
    return self;
end;
exports.IntervalSystem.prototype.____constructor = function(self, interval, onUpdate)
    self._id = exports.IntervalSystem._id;
    self._aspect = exports.IntervalSystem._aspect;
    self.update = function(____, dt)
        local elapsed = self.elapsed + dt;
        if elapsed >= self.interval then
            self.elapsed = elapsed - self.interval;
            self:onUpdate(self.entities);
        else
            self.elapsed = elapsed;
        end
    end;
    System.prototype.____constructor(self);
    self.interval = interval;
    self.elapsed = 0;
    self.onUpdate = onUpdate;
end;
exports.IntervalSystem._id = "IntervalSystem";
exports.IntervalSystem._aspect = Aspect.new();
return exports;
