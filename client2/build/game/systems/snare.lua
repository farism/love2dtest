--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_System = require("ecs.System");
local System = __TSTL_System.System;
local __TSTL_flags = require("game.flags");
local SystemFlag = __TSTL_flags.SystemFlag;
local __TSTL_Aspect = require("ecs.Aspect");
local NeverAspect = __TSTL_Aspect.NeverAspect;
local __TSTL_collision = require("game.utils.collision");
local check = __TSTL_collision.check;
local hasComponent = __TSTL_collision.hasComponent;
local __TSTL_Player = require("game.components.Player");
local Player = __TSTL_Player.Player;
local __TSTL_Snare = require("game.components.Snare");
local Snare = __TSTL_Snare.Snare;
exports.SnareSystem = exports.SnareSystem or {};
exports.SnareSystem.__index = exports.SnareSystem;
exports.SnareSystem.prototype = exports.SnareSystem.prototype or {};
exports.SnareSystem.prototype.__index = exports.SnareSystem.prototype;
exports.SnareSystem.prototype.constructor = exports.SnareSystem;
exports.SnareSystem.____super = System;
setmetatable(exports.SnareSystem, exports.SnareSystem.____super);
setmetatable(exports.SnareSystem.prototype, exports.SnareSystem.____super.prototype);
exports.SnareSystem.new = function(...)
    local self = setmetatable({}, exports.SnareSystem.prototype);
    self:____constructor(...);
    return self;
end;
exports.SnareSystem.prototype.____constructor = function(self, ...)
    System.prototype.____constructor(self, ...);
    self._id = exports.SnareSystem._id;
    self._flag = exports.SnareSystem._flag;
    self._aspect = exports.SnareSystem._aspect;
    self.beginContact = function(____, a, b, contact)
        local result = check(nil, a, b, {hasComponent(nil, Player), hasComponent(nil, Snare)});
        if not result then
            return;
        end
    end;
end;
exports.SnareSystem._id = "Snare";
exports.SnareSystem._flag = SystemFlag.Snare;
exports.SnareSystem._aspect = NeverAspect.new();
return exports;
