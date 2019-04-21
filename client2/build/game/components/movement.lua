--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_Component = require("ecs.Component");
local Component = __TSTL_Component.Component;
local __TSTL_flags = require("game.components.flags");
local Flag = __TSTL_flags.Flag;
exports.Dash = exports.Dash or {};
exports.Dash.__index = exports.Dash;
exports.Dash.prototype = exports.Dash.prototype or {};
exports.Dash.prototype.__index = exports.Dash.prototype;
exports.Dash.prototype.constructor = exports.Dash;
exports.Dash.____super = Component;
setmetatable(exports.Dash, exports.Dash.____super);
setmetatable(exports.Dash.prototype, exports.Dash.____super.prototype);
exports.Dash.new = function(...)
    local self = setmetatable({}, exports.Dash.prototype);
    self:____constructor(...);
    return self;
end;
exports.Dash.prototype.____constructor = function(self)
    self._id = exports.Dash._id;
    self._flag = Flag.Dash;
    self.direction = "right";
    self.left = false;
    self.right = false;
    self.jump = false;
    self.jumpCount = 0;
    Component.prototype.____constructor(self);
end;
exports.Dash._id = "Dash";
exports.Dash._flag = Flag.Dash;
return exports;
