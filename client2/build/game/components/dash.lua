--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_flags = require("game.flags");
local ComponentFlag = __TSTL_flags.ComponentFlag;
exports.Dash = exports.Dash or {};
exports.Dash.__index = exports.Dash;
exports.Dash.prototype = exports.Dash.prototype or {};
exports.Dash.prototype.__index = exports.Dash.prototype;
exports.Dash.prototype.constructor = exports.Dash;
exports.Dash.new = function(...)
    local self = setmetatable({}, exports.Dash.prototype);
    self:____constructor(...);
    return self;
end;
exports.Dash.prototype.____constructor = function(self, velocity)
    self._id = exports.Dash._id;
    self._flag = ComponentFlag.Dash;
    if velocity == nil then
        velocity = 0;
    end
    self.velocity = velocity;
end;
exports.Dash._id = "Dash";
exports.Dash._flag = ComponentFlag.Dash;
return exports;
