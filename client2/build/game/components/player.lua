--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_flags = require("game.flags")
local ComponentFlag = __TSTL_flags.ComponentFlag
____exports.Player = {}
local Player = ____exports.Player
Player.name = "Player"
Player.__index = Player
Player.prototype = {}
Player.prototype.__index = Player.prototype
Player.prototype.constructor = Player
function Player.new(...)
    local self = setmetatable({}, Player.prototype)
    self:____constructor(...)
    return self
end
function Player.prototype.____constructor(self, alias, money, lives, documents, checkpoint)
    self._id = ____exports.Player._id
    self._flag = ComponentFlag.Player
    if alias == nil then
        alias = ""
    end
    if money == nil then
        money = 0
    end
    if lives == nil then
        lives = 0
    end
    if documents == nil then
        documents = 0
    end
    if checkpoint == nil then
        checkpoint = 0
    end
    self.alias = alias
    self.money = money
    self.lives = lives
    self.documents = documents
    self.checkpoint = checkpoint
end
Player._id = "Player"
Player._flag = ComponentFlag.Player
return ____exports
