--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_Component = require("ecs.Component");
local Component = __TSTL_Component.Component;
local __TSTL_flags = require("game.components.flags");
local Flag = __TSTL_flags.Flag;
exports.Sound = exports.Sound or {};
exports.Sound.__index = exports.Sound;
exports.Sound.prototype = exports.Sound.prototype or {};
exports.Sound.prototype.__index = exports.Sound.prototype;
exports.Sound.prototype.constructor = exports.Sound;
exports.Sound.____super = Component;
setmetatable(exports.Sound, exports.Sound.____super);
setmetatable(exports.Sound.prototype, exports.Sound.____super.prototype);
exports.Sound.new = function(...)
    local self = setmetatable({}, exports.Sound.prototype);
    self:____constructor(...);
    return self;
end;
exports.Sound.prototype.____constructor = function(self, filepath, sound)
    self._id = exports.Sound._id;
    self._flag = Flag.Sound;
    if filepath == nil then
        filepath = "";
    end
    Component.prototype.____constructor(self);
    self.filepath = filepath;
    self.sound = sound;
end;
exports.Sound._id = "Sound";
exports.Sound._flag = Flag.Sound;
return exports;
