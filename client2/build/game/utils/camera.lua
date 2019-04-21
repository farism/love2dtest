--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_entity = require("ecs.entity");
local Entity = __TSTL_entity.Entity;
exports.Camera = exports.Camera or {};
exports.Camera.__index = exports.Camera;
exports.Camera.prototype = exports.Camera.prototype or {};
exports.Camera.prototype.__index = exports.Camera.prototype;
exports.Camera.prototype.constructor = exports.Camera;
exports.Camera.new = function(...)
    local self = setmetatable({}, exports.Camera.prototype);
    self:____constructor(...);
    return self;
end;
exports.Camera.prototype.____constructor = function(self, initialDirection)
    self.clear = function(____)
        love.graphics.pop();
    end;
    self.set = function(____)
        love.graphics.push();
        love.graphics.translate(math.floor((-self.x) + 0.5), math.floor((-self.y) + 0.5));
    end;
    self.update = function(____, dt, target)
    end;
    self.x = 0;
    self.y = 0;
    self.offset = 0;
    self.direction = initialDirection;
end;
return exports;
