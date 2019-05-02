--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_Aspect = require("ecs.Aspect");
local Aspect = __TSTL_Aspect.Aspect;
local __TSTL_System = require("ecs.System");
local System = __TSTL_System.System;
local __TSTL_Container = require("game.components.Container");
local Container = __TSTL_Container.Container;
local __TSTL_flags = require("game.flags");
local SystemFlag = __TSTL_flags.SystemFlag;
exports.ContainerSystem = exports.ContainerSystem or {};
exports.ContainerSystem.__index = exports.ContainerSystem;
exports.ContainerSystem.prototype = exports.ContainerSystem.prototype or {};
exports.ContainerSystem.prototype.__index = exports.ContainerSystem.prototype;
exports.ContainerSystem.prototype.constructor = exports.ContainerSystem;
exports.ContainerSystem.____super = System;
setmetatable(exports.ContainerSystem, exports.ContainerSystem.____super);
setmetatable(exports.ContainerSystem.prototype, exports.ContainerSystem.____super.prototype);
exports.ContainerSystem.new = function(...)
    local self = setmetatable({}, exports.ContainerSystem.prototype);
    self:____constructor(...);
    return self;
end;
exports.ContainerSystem.prototype.____constructor = function(self, ...)
    System.prototype.____constructor(self, ...);
    self._id = exports.ContainerSystem._id;
    self._flag = exports.ContainerSystem._flag;
    self._aspect = exports.ContainerSystem._aspect;
    self.update = function(____, dt)
        self.entities:forEach(function(____, entity)
        end);
    end;
end;
exports.ContainerSystem._id = "Container";
exports.ContainerSystem._flag = SystemFlag.Container;
exports.ContainerSystem._aspect = Aspect.new({Container});
return exports;
