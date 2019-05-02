--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_System = require("ecs.System");
local System = __TSTL_System.System;
local __TSTL_flags = require("game.flags");
local SystemFlag = __TSTL_flags.SystemFlag;
local __TSTL_Aspect = require("ecs.Aspect");
local Aspect = __TSTL_Aspect.Aspect;
local __TSTL_GameObject = require("game.components.GameObject");
local GameObject = __TSTL_GameObject.GameObject;
local __TSTL_Position = require("game.components.Position");
local Position = __TSTL_Position.Position;
exports.SyncBodyPositionSystem = exports.SyncBodyPositionSystem or {};
exports.SyncBodyPositionSystem.__index = exports.SyncBodyPositionSystem;
exports.SyncBodyPositionSystem.prototype = exports.SyncBodyPositionSystem.prototype or {};
exports.SyncBodyPositionSystem.prototype.__index = exports.SyncBodyPositionSystem.prototype;
exports.SyncBodyPositionSystem.prototype.constructor = exports.SyncBodyPositionSystem;
exports.SyncBodyPositionSystem.____super = System;
setmetatable(exports.SyncBodyPositionSystem, exports.SyncBodyPositionSystem.____super);
setmetatable(exports.SyncBodyPositionSystem.prototype, exports.SyncBodyPositionSystem.____super.prototype);
exports.SyncBodyPositionSystem.new = function(...)
    local self = setmetatable({}, exports.SyncBodyPositionSystem.prototype);
    self:____constructor(...);
    return self;
end;
exports.SyncBodyPositionSystem.prototype.____constructor = function(self, ...)
    System.prototype.____constructor(self, ...);
    self._id = exports.SyncBodyPositionSystem._id;
    self._flag = exports.SyncBodyPositionSystem._flag;
    self._aspect = exports.SyncBodyPositionSystem._aspect;
    self.update = function(____, dt)
        self.entities:forEach(function(____, entity)
            local gameObject = entity:as(GameObject);
            local position = entity:as(Position);
            if (not gameObject) or (not position) then
                return;
            end
            local body = gameObject.fixture:getBody();
            local x, y = body:getPosition();
            position.x = x;
            position.y = y;
        end);
    end;
end;
exports.SyncBodyPositionSystem._id = "SyncBodyPosition";
exports.SyncBodyPositionSystem._flag = SystemFlag.SyncBodyPosition;
exports.SyncBodyPositionSystem._aspect = Aspect.new({GameObject, Position});
return exports;
