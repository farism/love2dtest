--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_flags = require("game.components.flags");
local Flag = __TSTL_flags.Flag;
exports.Input = exports.Input or {};
exports.Input.__index = exports.Input;
exports.Input.prototype = exports.Input.prototype or {};
exports.Input.prototype.__index = exports.Input.prototype;
exports.Input.prototype.constructor = exports.Input;
exports.Input.new = function(...)
    local self = setmetatable({}, exports.Input.prototype);
    self:____constructor(...);
    return self;
end;
exports.Input.prototype.____constructor = function(self)
    self._id = exports.Input._id;
    self._flag = Flag.Input;
end;
exports.Input._id = "Input";
exports.Input._flag = Flag.Input;
return exports;
