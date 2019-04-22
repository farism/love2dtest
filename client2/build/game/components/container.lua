--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_Component = require("ecs.Component");
local Component = __TSTL_Component.Component;
local __TSTL_flags = require("game.components.flags");
local Flag = __TSTL_flags.Flag;
exports.Container = exports.Container or {};
exports.Container.__index = exports.Container;
exports.Container.prototype = exports.Container.prototype or {};
exports.Container.prototype.__index = exports.Container.prototype;
exports.Container.prototype.constructor = exports.Container;
exports.Container.new = function(...)
    local self = setmetatable({}, exports.Container.prototype);
    self:____constructor(...);
    return self;
end;
exports.Container.prototype.____constructor = function(self)
    self._id = exports.Container._id;
    self._flag = Flag.Container;
end;
exports.Container._id = "Container";
exports.Container._flag = Flag.Container;
return exports;
