--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_System = require("ecs.System")
local System = __TSTL_System.System
local __TSTL_flags = require("game.flags")
local SystemFlag = __TSTL_flags.SystemFlag
local __TSTL_Aspect = require("ecs.Aspect")
local Aspect = __TSTL_Aspect.Aspect
local __TSTL_Player = require("game.components.Player")
local Player = __TSTL_Player.Player
local __TSTL_State = require("game.State")
local State = __TSTL_State.State
____exports.GameOverSystem = {}
local GameOverSystem = ____exports.GameOverSystem
GameOverSystem.name = "GameOverSystem"
GameOverSystem.__index = GameOverSystem
GameOverSystem.prototype = {}
GameOverSystem.prototype.__index = GameOverSystem.prototype
GameOverSystem.prototype.constructor = GameOverSystem
GameOverSystem.____super = System
setmetatable(GameOverSystem, GameOverSystem.____super)
setmetatable(GameOverSystem.prototype, GameOverSystem.____super.prototype)
function GameOverSystem.new(...)
    local self = setmetatable({}, GameOverSystem.prototype)
    self:____constructor(...)
    return self
end
function GameOverSystem.prototype.____constructor(self, ...)
    System.prototype.____constructor(self, ...)
    self._id = ____exports.GameOverSystem._id
    self._flag = ____exports.GameOverSystem._flag
    self._aspect = ____exports.GameOverSystem._aspect
    self.update = function(____, dt)
        self.entities:forEach(function(____, entity)
            local player = entity:as(Player)
            if player and player.lives == 0 then
            end
        end)
    end
end
GameOverSystem._id = "GameOver"
GameOverSystem._flag = SystemFlag.GameOver
GameOverSystem._aspect = Aspect.new({Player})
return ____exports
