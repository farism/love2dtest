--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_Component = require("ecs.Component");
local Component = __TSTL_Component.Component;
local __TSTL_Entity = require("ecs.Entity");
local Entity = __TSTL_Entity.Entity;
local __TSTL_flags = require("game.components.flags");
local Flag = __TSTL_flags.Flag;
exports.Attack = exports.Attack or {};
exports.Attack.__index = exports.Attack;
exports.Attack.prototype = exports.Attack.prototype or {};
exports.Attack.prototype.__index = exports.Attack.prototype;
exports.Attack.prototype.constructor = exports.Attack;
exports.Attack.____super = Component;
setmetatable(exports.Attack, exports.Attack.____super);
setmetatable(exports.Attack.prototype, exports.Attack.____super.prototype);
exports.Attack.new = function(...)
    local self = setmetatable({}, exports.Attack.prototype);
    self:____constructor(...);
    return self;
end;
exports.Attack.prototype.____constructor = function(self, target)
    self._id = exports.Attack._id;
    self._flag = Flag.Attack;
    Component.prototype.____constructor(self);
    self.target = target;
end;
exports.Attack._id = "Attack";
exports.Attack._flag = Flag.Attack;
return exports;