--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_flags = require("game.flags");
local ComponentFlag = __TSTL_flags.ComponentFlag;
exports.Player = exports.Player or {};
exports.Player.__index = exports.Player;
exports.Player.prototype = exports.Player.prototype or {};
exports.Player.prototype.__index = exports.Player.prototype;
exports.Player.prototype.constructor = exports.Player;
exports.Player.new = function(...)
    local self = setmetatable({}, exports.Player.prototype);
    self:____constructor(...);
    return self;
end;
exports.Player.prototype.____constructor = function(self, alias, money, lives, documents, checkpoint)
    self._id = exports.Player._id;
    self._flag = ComponentFlag.Player;
    if alias == nil then
        alias = "";
    end
    if money == nil then
        money = 0;
    end
    if lives == nil then
        lives = 0;
    end
    if documents == nil then
        documents = 0;
    end
    if checkpoint == nil then
        checkpoint = 0;
    end
    self.alias = alias;
    self.money = money;
    self.lives = lives;
    self.documents = documents;
    self.checkpoint = checkpoint;
end;
exports.Player._id = "Player";
exports.Player._flag = ComponentFlag.Player;
return exports;
