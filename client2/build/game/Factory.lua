--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_conf = require("conf");
local WINDOW_WIDTH = __TSTL_conf.WINDOW_WIDTH;
local WINDOW_HEIGHT = __TSTL_conf.WINDOW_HEIGHT;
local __TSTL_Entity = require("ecs.Entity");
local Entity = __TSTL_Entity.Entity;
local __TSTL_Component = require("ecs.Component");
local Component = __TSTL_Component.Component;
local __TSTL_GameObject = require("game.components.GameObject");
local GameObject = __TSTL_GameObject.GameObject;
local __TSTL_Player = require("game.components.Player");
local Player = __TSTL_Player.Player;
local __TSTL_Position = require("game.components.Position");
local Position = __TSTL_Position.Position;
local __TSTL_Input = require("game.components.Input");
local Input = __TSTL_Input.Input;
local __TSTL_Health = require("game.components.Health");
local Health = __TSTL_Health.Health;
local __TSTL_Abilities = require("game.components.Abilities");
local Abilities = __TSTL_Abilities.Abilities;
local __TSTL_Animation = require("game.components.Animation");
local Animation = __TSTL_Animation.Animation;
local __TSTL_Movement = require("game.components.Movement");
local Movement = __TSTL_Movement.Movement;
local Category = {};
Category.Static = 1;
Category[1] = "Static";
Category.Player = 2;
Category[2] = "Player";
Category.PlayerAttack = 3;
Category[3] = "PlayerAttack";
Category.Enemy = 4;
Category[4] = "Enemy";
Category.EnemyAttack = 5;
Category[5] = "EnemyAttack";
Category.Container = 6;
Category[6] = "Container";
Category.Bomb = 7;
Category[7] = "Bomb";
Category.Aggression = 8;
Category[8] = "Aggression";
local Blueprint = {};
Blueprint.Ground = "ground";
Blueprint.ground = "Ground";
Blueprint.Mob = "mob";
Blueprint.mob = "Mob";
Blueprint.Slope = "slope";
Blueprint.slope = "Slope";
exports.createPlayer = function(____, manager, initX, initY)
    if initX == nil then
        initX = 0;
    end
    if initY == nil then
        initY = 0;
    end
    local body = love.physics.newBody(manager.world, initX, initY, "dynamic");
    local shape = love.physics.newCircleShape(16);
    local fixture = love.physics.newFixture(body, shape, 1);
    body:setFixedRotation(true);
    fixture:setFriction(1);
    fixture:setCategory(Category.Player);
    fixture:setMask(Category.Enemy);
    local entity = manager:createEntity();
    entity.userData = {blueprint = Blueprint.Ground};
    entity:addAll({Abilities.new(), GameObject.new(entity, fixture), Health.new(), Input.new(), Player.new(), Position.new()});
end;
exports.createMob = function(____, manager, initX, initY)
    if initX == nil then
        initX = 0;
    end
    if initY == nil then
        initY = 0;
    end
    local body = love.physics.newBody(manager.world, initX, initY, "dynamic");
    local shape = love.physics.newRectangleShape(32, 32);
    local fixture = love.physics.newFixture(body, shape, 1);
    body:setFixedRotation(true);
    fixture:setCategory(Category.Enemy);
    local entity = manager:createEntity();
    entity.userData.blueprint = Blueprint.Mob;
    entity:addAll({GameObject.new(entity, fixture), Health.new(1, 0), Movement.new(), Position.new()});
    return entity;
end;
exports.createSlashMob = function(____, manager, initX, initY)
    if initX == nil then
        initX = 0;
    end
    if initY == nil then
        initY = 0;
    end
    local body = love.physics.newBody(manager.world, initX, initY, "dynamic");
    local shape = love.physics.newRectangleShape(32, 32);
    local fixture = love.physics.newFixture(body, shape, 1);
    body:setFixedRotation(true);
    fixture:setCategory(Category.Enemy);
    local entity = manager:createEntity();
    entity.userData.blueprint = Blueprint.Mob;
    entity:addAll({GameObject.new(entity, fixture), Health.new(1, 0), Movement.new(), Position.new()});
    return entity;
end;
exports.createSlope = function(____, manager)
    local body = love.physics.newBody(manager.world, 1000, 0, "static");
    local shape = love.physics.newPolygonShape(500, WINDOW_HEIGHT - 30, 1500, WINDOW_HEIGHT - 130, 1500, WINDOW_HEIGHT - 30);
    local fixture = love.physics.newFixture(body, shape, 1);
    local entity = manager:createEntity();
    entity.userData = {blueprint = Blueprint.Slope};
    entity:addAll({GameObject.new(entity, fixture)});
    return entity;
end;
exports.createGround = function(____, manager)
    local body = love.physics.newBody(manager.world, WINDOW_WIDTH / 2, WINDOW_HEIGHT - 15, "static");
    local shape = love.physics.newRectangleShape(WINDOW_WIDTH * 10, 30);
    local fixture = love.physics.newFixture(body, shape, 1);
    local entity = manager:createEntity();
    entity.userData = {blueprint = Blueprint.Ground};
    entity:addAll({GameObject.new(entity, fixture)});
    return entity;
end;
return exports;
