--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
-- Lua Library inline imports
function __TS__ArrayForEach(arr, callbackFn)
    do
        local i = 0
        while i < #arr do
            callbackFn(_G, arr[i + 1], i, arr)
            i = i + 1
        end
    end
end

local ____exports = {}
local timer = require("game.utils.timer")
local Factory = require("game.utils.factory")
local __TSTL_camera = require("game.utils.camera")
local Camera = __TSTL_camera.Camera
local __TSTL_manager = require("ecs.manager")
local Manager = __TSTL_manager.Manager
local __TSTL_InputSystem = require("game.systems.InputSystem")
local InputSystem = __TSTL_InputSystem.InputSystem
local __TSTL_InputMovement = require("game.systems.InputMovement")
local InputMovementSystem = __TSTL_InputMovement.InputMovementSystem
local __TSTL_RenderSystem = require("game.systems.RenderSystem")
local RenderSystem = __TSTL_RenderSystem.RenderSystem
local __TSTL_ProjectileSystem = require("game.systems.ProjectileSystem")
local ProjectileSystem = __TSTL_ProjectileSystem.ProjectileSystem
local __TSTL_State = require("game.State")
local State = __TSTL_State.State
local __TSTL_JumpReset = require("game.systems.JumpReset")
local JumpResetSystem = __TSTL_JumpReset.JumpResetSystem
local __TSTL_SyncBodyPosition = require("game.systems.SyncBodyPosition")
local SyncBodyPositionSystem = __TSTL_SyncBodyPosition.SyncBodyPositionSystem
local __TSTL_Checkpoint = require("game.systems.Checkpoint")
local CheckpointSystem = __TSTL_Checkpoint.CheckpointSystem
local __TSTL_GameOver = require("game.systems.GameOver")
local GameOverSystem = __TSTL_GameOver.GameOverSystem
local __TSTL_Damage = require("game.systems.Damage")
local DamageSystem = __TSTL_Damage.DamageSystem
local __TSTL_Container = require("game.systems.Container")
local ContainerSystem = __TSTL_Container.ContainerSystem
local __TSTL_Aggression = require("game.systems.Aggression")
local AggressionSystem = __TSTL_Aggression.AggressionSystem
local __TSTL_AnimateSprite = require("game.systems.AnimateSprite")
local AnimateSpriteSystem = __TSTL_AnimateSprite.AnimateSpriteSystem
local __TSTL_FallDeath = require("game.systems.FallDeath")
local FallDeathSystem = __TSTL_FallDeath.FallDeathSystem
local __TSTL_Abilities = require("game.systems.Abilities")
local AbilitiesSystem = __TSTL_Abilities.AbilitiesSystem
local __TSTL_Entity = require("ecs.Entity")
local Entity = __TSTL_Entity.Entity
local __TSTL_Dash = require("game.systems.Dash")
local DashSystem = __TSTL_Dash.DashSystem
local __TSTL_Death = require("game.systems.Death")
local DeathSystem = __TSTL_Death.DeathSystem
local __TSTL_Respawn = require("game.systems.Respawn")
local RespawnSystem = __TSTL_Respawn.RespawnSystem
local __TSTL_Platform = require("game.systems.Platform")
local PlatformSystem = __TSTL_Platform.PlatformSystem
local initializeBlueprints
initializeBlueprints = function(____, manager)
    local blueprints = {
        Factory.createPlayer,
        Factory.createGround,
        Factory.createSlope,
        Factory:createIcicle(200, 200),
    }
    __TS__ArrayForEach(blueprints, function(____, blueprint) return blueprint(nil, manager) end)
end
____exports.Game = {}
local Game = ____exports.Game
Game.name = "Game"
Game.__index = Game
Game.prototype = {}
Game.prototype.__index = Game.prototype
Game.prototype.constructor = Game
function Game.new(...)
    local self = setmetatable({}, Game.prototype)
    self:____constructor(...)
    return self
end
function Game.prototype.____constructor(self)
    self.setState = function(____, state)
        self.state = state
    end
    self.restart = function()
    end
    self.keyboard = function(____, key, scancode, isRepeat, isPressed)
        self.manager:keyboard(key, scancode, isRepeat, isPressed)
    end
    self.mouse = function(____, x, y, isTouch)
        self.manager:mouse(x, y, isTouch)
    end
    self.update = function(____, dt)
        if self.state == State.PLAYING then
            timer:update(dt)
            self.world:update(dt)
            self.manager:update(dt)
        end
    end
    self.draw = function()
        self.manager:draw()
    end
    self.state = State.PLAYING
    self.world = love.physics.newWorld(0, 9.81, true)
    love.physics.setMeter(256)
    self.world:setCallbacks(function(a, b, contact)
        self.manager:beginContact(a, b, contact)
    end, function(a, b, contact)
        self.manager:endContact(a, b, contact)
    end)
    self.camera = Camera.new("right")
    self.manager = Manager.new(self.world)
    self.manager:addSystems({
        InputSystem.new(),
        GameOverSystem.new(),
        AbilitiesSystem.new(),
        AggressionSystem.new(),
        DamageSystem.new(),
        DeathSystem.new(),
        CheckpointSystem.new(),
        ContainerSystem.new(),
        FallDeathSystem.new(),
        InputMovementSystem.new(),
        JumpResetSystem.new(),
        PlatformSystem.new(),
        ProjectileSystem.new(),
        DashSystem.new(),
        RespawnSystem.new(),
        SyncBodyPositionSystem.new(),
        AnimateSpriteSystem.new(),
        RenderSystem.new(),
    })
    initializeBlueprints(nil, self.manager)
end
return ____exports
