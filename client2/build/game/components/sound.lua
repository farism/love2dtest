--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_flags = require("game.flags");
local ComponentFlag = __TSTL_flags.ComponentFlag;
exports.Sound = exports.Sound or {};
exports.Sound.__index = exports.Sound;
exports.Sound.prototype = exports.Sound.prototype or {};
exports.Sound.prototype.__index = exports.Sound.prototype;
exports.Sound.prototype.constructor = exports.Sound;
exports.Sound.new = function(...)
    local self = setmetatable({}, exports.Sound.prototype);
    self:____constructor(...);
    return self;
end;
exports.Sound.prototype.____constructor = function(self, filepath, sound)
    self._id = exports.Sound._id;
    self._flag = ComponentFlag.Sound;
    if filepath == nil then
        filepath = "";
    end
    self.filepath = filepath;
    self.sound = sound;
end;
exports.Sound._id = "Sound";
exports.Sound._flag = ComponentFlag.Sound;
return exports;
