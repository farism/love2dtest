--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_Entity = require("ecs.Entity");
local Entity = __TSTL_Entity.Entity;
local __TSTL_flags = require("game.flags");
local ComponentFlag = __TSTL_flags.ComponentFlag;
exports.Attack = exports.Attack or {};
exports.Attack.__index = exports.Attack;
exports.Attack.prototype = exports.Attack.prototype or {};
exports.Attack.prototype.__index = exports.Attack.prototype;
exports.Attack.prototype.constructor = exports.Attack;
exports.Attack.new = function(...)
    local self = setmetatable({}, exports.Attack.prototype);
    self:____constructor(...);
    return self;
end;
exports.Attack.prototype.____constructor = function(self, target)
    self._id = exports.Attack._id;
    self._flag = ComponentFlag.Attack;
    self.target = target;
end;
exports.Attack._id = "Attack";
exports.Attack._flag = ComponentFlag.Attack;
return exports;
