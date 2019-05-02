--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
-- Lua Library inline imports
__TS__ArrayForEach = function(arr, callbackFn)
    do
        local i = 0;
        while i < (#arr) do
            callbackFn(_G, arr[i + 1], i, arr);
            i = i + 1;
        end
    end
end;

local exports = exports or {};
local Factory = require("game.utils.factory");
local __TSTL_camera = require("game.utils.camera");
local Camera = __TSTL_camera.Camera;
local __TSTL_manager = require("ecs.manager");
local Manager = __TSTL_manager.Manager;
local __TSTL_InputSystem = require("game.systems.InputSystem");
local InputSystem = __TSTL_InputSystem.InputSystem;
local __TSTL_InputMovement = require("game.systems.InputMovement");
local InputMovementSystem = __TSTL_InputMovement.InputMovementSystem;
local __TSTL_RenderSystem = require("game.systems.RenderSystem");
local RenderSystem = __TSTL_RenderSystem.RenderSystem;
local __TSTL_ProjectileSystem = require("game.systems.ProjectileSystem");
local ProjectileSystem = __TSTL_ProjectileSystem.ProjectileSystem;
local __TSTL_State = require("game.State");
local State = __TSTL_State.State;
local __TSTL_JumpReset = require("game.systems.JumpReset");
local JumpResetSystem = __TSTL_JumpReset.JumpResetSystem;
local __TSTL_SyncBodyPosition = require("game.systems.SyncBodyPosition");
local SyncBodyPositionSystem = __TSTL_SyncBodyPosition.SyncBodyPositionSystem;
local __TSTL_Checkpoint = require("game.systems.Checkpoint");
local CheckpointSystem = __TSTL_Checkpoint.CheckpointSystem;
local initializeBlueprints;
initializeBlueprints = function(____, manager)
    local blueprints = {Factory.createPlayer, Factory.createGround, Factory.createSlope};
    __TS__ArrayForEach(blueprints, function(____, blueprint)
        return blueprint(nil, manager);
    end);
end;
exports.Game = exports.Game or {};
exports.Game.__index = exports.Game;
exports.Game.prototype = exports.Game.prototype or {};
exports.Game.prototype.__index = exports.Game.prototype;
exports.Game.prototype.constructor = exports.Game;
exports.Game.new = function(...)
    local self = setmetatable({}, exports.Game.prototype);
    self:____constructor(...);
    return self;
end;
exports.Game.prototype.____constructor = function(self)
    self.setState = function(____, state)
        self.state = state;
    end;
    self.restart = function(____)
    end;
    self.keyboard = function(____, key, scancode, isRepeat, isPressed)
        self.manager:keyboard(key, scancode, isRepeat, isPressed);
    end;
    self.mouse = function(____, x, y, isTouch)
        self.manager:mouse(x, y, isTouch);
    end;
    self.update = function(____, dt)
        if self.state == State.PLAYING then
            self.world:update(dt);
            self.manager:update(dt);
        end
    end;
    self.draw = function(____)
        self.manager:draw();
    end;
    self.state = State.PLAYING;
    self.world = love.physics.newWorld(0, 9.81, true);
    self.world:setCallbacks(function(a, b, contact)
        self.manager:beginContact(a, b, contact);
    end, function(a, b, contact)
        self.manager:endContact(a, b, contact);
    end);
    love.physics.setMeter(256);
    self.camera = Camera.new("right");
    self.manager = Manager.new(self.world);
    self.manager:addSystem(InputSystem.new());
    self.manager:addSystem(InputMovementSystem.new());
    self.manager:addSystem(CheckpointSystem.new());
    self.manager:addSystem(ProjectileSystem.new());
    self.manager:addSystem(JumpResetSystem.new());
    self.manager:addSystem(SyncBodyPositionSystem.new());
    self.manager:addSystem(RenderSystem.new());
    initializeBlueprints(nil, self.manager);
end;
return exports;
