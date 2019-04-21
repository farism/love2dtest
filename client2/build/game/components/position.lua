--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_Component = require("ecs.Component");
local Component = __TSTL_Component.Component;
local __TSTL_flags = require("game.components.flags");
local Flag = __TSTL_flags.Flag;
exports.Position = exports.Position or {};
exports.Position.__index = exports.Position;
exports.Position.prototype = exports.Position.prototype or {};
exports.Position.prototype.__index = exports.Position.prototype;
exports.Position.prototype.constructor = exports.Position;
exports.Position.____super = Component;
setmetatable(exports.Position, exports.Position.____super);
setmetatable(exports.Position.prototype, exports.Position.____super.prototype);
exports.Position.new = function(...)
    local self = setmetatable({}, exports.Position.prototype);
    self:____constructor(...);
    return self;
end;
exports.Position.prototype.____constructor = function(self, x, y)
    self._id = exports.Position._id;
    self._flag = Flag.Position;
    if x == nil then
        x = 0;
    end
    if y == nil then
        y = 0;
    end
    Component.prototype.____constructor(self);
    self.x = x;
    self.y = y;
end;
exports.Position._id = "Position";
exports.Position._flag = Flag.Position;
return exports;
