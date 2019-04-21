--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_Component = require("ecs.Component");
local Component = __TSTL_Component.Component;
local __TSTL_flags = require("game.components.flags");
local Flag = __TSTL_flags.Flag;
exports.Checkpoint = exports.Checkpoint or {};
exports.Checkpoint.__index = exports.Checkpoint;
exports.Checkpoint.prototype = exports.Checkpoint.prototype or {};
exports.Checkpoint.prototype.__index = exports.Checkpoint.prototype;
exports.Checkpoint.prototype.constructor = exports.Checkpoint;
exports.Checkpoint.____super = Component;
setmetatable(exports.Checkpoint, exports.Checkpoint.____super);
setmetatable(exports.Checkpoint.prototype, exports.Checkpoint.____super.prototype);
exports.Checkpoint.new = function(...)
    local self = setmetatable({}, exports.Checkpoint.prototype);
    self:____constructor(...);
    return self;
end;
exports.Checkpoint.prototype.____constructor = function(self, index, visited)
    self._id = exports.Checkpoint._id;
    self._flag = Flag.Checkpoint;
    if index == nil then
        index = 1;
    end
    if visited == nil then
        visited = false;
    end
    Component.prototype.____constructor(self);
    self.index = index;
    self.visited = visited;
end;
exports.Checkpoint._id = "Checkpoint";
exports.Checkpoint._flag = Flag.Checkpoint;
return exports;
