--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_System = require("ecs.System");
local System = __TSTL_System.System;
local __TSTL_GameObject = require("game.components.GameObject");
local GameObject = __TSTL_GameObject.GameObject;
local __TSTL_flags = require("game.flags");
local SystemFlag = __TSTL_flags.SystemFlag;
exports.Input = exports.Input or {};
exports.Input.__index = exports.Input;
exports.Input.prototype = exports.Input.prototype or {};
exports.Input.prototype.__index = exports.Input.prototype;
exports.Input.prototype.constructor = exports.Input;
exports.Input.____super = System;
setmetatable(exports.Input, exports.Input.____super);
setmetatable(exports.Input.prototype, exports.Input.____super.prototype);
exports.Input.new = function(...)
    local self = setmetatable({}, exports.Input.prototype);
    self:____constructor(...);
    return self;
end;
exports.Input.prototype.____constructor = function(self, ...)
    System.prototype.____constructor(self, ...);
    self._id = exports.Input._id;
    self._flag = exports.Input._flag;
    self.update = function(____, dt)
    end;
    self.draw = function(____)
        self.entities:forEach(function(____, entity)
        end);
    end;
end;
exports.Input._id = "Input";
exports.Input._flag = SystemFlag.Input;
return exports;
