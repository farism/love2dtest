--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
exports.Component = exports.Component or {};
exports.Component.__index = exports.Component;
exports.Component.prototype = exports.Component.prototype or {};
exports.Component.prototype.__index = exports.Component.prototype;
exports.Component.prototype.constructor = exports.Component;
exports.Component.new = function(...)
    local self = setmetatable({}, exports.Component.prototype);
    self:____constructor(...);
    return self;
end;
exports.Component.prototype.____constructor = function(self)
    self._flag = exports.Component._flag;
end;
exports.Component._flag = 0;
return exports;
