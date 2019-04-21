--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_component = require("ecs.component");
local Component = __TSTL_component.Component;
local __TSTL_flags = require("game.components.flags");
local Flag = __TSTL_flags.Flag;
local __TSTL_Entity = require("ecs.Entity");
local Entity = __TSTL_Entity.Entity;
exports.Aggression = exports.Aggression or {};
exports.Aggression.__index = exports.Aggression;
exports.Aggression.prototype = exports.Aggression.prototype or {};
exports.Aggression.prototype.__index = exports.Aggression.prototype;
exports.Aggression.prototype.constructor = exports.Aggression;
exports.Aggression.____super = Component;
setmetatable(exports.Aggression, exports.Aggression.____super);
setmetatable(exports.Aggression.prototype, exports.Aggression.____super.prototype);
exports.Aggression.new = function(...)
    local self = setmetatable({}, exports.Aggression.prototype);
    self:____constructor(...);
    return self;
end;
exports.Aggression.prototype.____constructor = function(self, world, entity, x, y, width, height, duration)
    self._id = exports.Aggression._id;
    self._flag = Flag.Aggression;
    self.destroy = function(____)
        self.fixture:getBody():destroy();
    end;
    if x == nil then
        x = 0;
    end
    if y == nil then
        y = 0;
    end
    if width == nil then
        width = 0;
    end
    if height == nil then
        height = 0;
    end
    if duration == nil then
        duration = 0;
    end
    Component.prototype.____constructor(self);
    self.width = width;
    self.height = height;
    self.duration = duration;
    self.fixture = love.physics.newFixture(love.physics.newBody(world, x, y, "kinematic"), love.physics.newRectangleShape(width, height), 1);
    self.fixture:setSensor(true);
    self.fixture:setCategory(8);
    self.fixture:setUserData({entity = entity, aggression = true});
end;
exports.Aggression._id = "Aggression";
exports.Aggression._flag = Flag.Aggression;
return exports;
