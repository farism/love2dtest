--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_flags = require("game.flags");
local ComponentFlag = __TSTL_flags.ComponentFlag;
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
    self._flag = ComponentFlag.Container;
end;
exports.Container._id = "Container";
exports.Container._flag = ComponentFlag.Container;
return exports;
