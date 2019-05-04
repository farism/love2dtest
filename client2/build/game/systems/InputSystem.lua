--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_Aspect = require("ecs.Aspect")
local Aspect = __TSTL_Aspect.Aspect
local __TSTL_System = require("ecs.System")
local System = __TSTL_System.System
local __TSTL_Abilities = require("game.components.Abilities")
local Abilities = __TSTL_Abilities.Abilities
local AbilityType = __TSTL_Abilities.AbilityType
local __TSTL_Input = require("game.components.Input")
local Input = __TSTL_Input.Input
local __TSTL_Movement = require("game.components.Movement")
local Direction = __TSTL_Movement.Direction
local Movement = __TSTL_Movement.Movement
local __TSTL_flags = require("game.flags")
local SystemFlag = __TSTL_flags.SystemFlag
local Keymap = {}
Keymap.Left = "a"
Keymap.a = "Left"
Keymap.Right = "d"
Keymap.d = "Right"
Keymap.Jump = "space"
Keymap.space = "Jump"
Keymap.Throw = "j"
Keymap.j = "Throw"
Keymap.Dash = "k"
Keymap.k = "Dash"
____exports.InputSystem = {}
local InputSystem = ____exports.InputSystem
InputSystem.name = "InputSystem"
InputSystem.__index = InputSystem
InputSystem.prototype = {}
InputSystem.prototype.__index = InputSystem.prototype
InputSystem.prototype.constructor = InputSystem
InputSystem.____super = System
setmetatable(InputSystem, InputSystem.____super)
setmetatable(InputSystem.prototype, InputSystem.____super.prototype)
function InputSystem.new(...)
    local self = setmetatable({}, InputSystem.prototype)
    self:____constructor(...)
    return self
end
function InputSystem.prototype.____constructor(self, ...)
    System.prototype.____constructor(self, ...)
    self._id = ____exports.InputSystem._id
    self._flag = ____exports.InputSystem._flag
    self._aspect = ____exports.InputSystem._aspect
    self.keyboard = function(____, key, scancode, isRepeat, isPressed)
        self.entities:forEach(function(____, entity)
            local abilities = entity:as(Abilities)
            local movement = entity:as(Movement)
            if not abilities or not movement then
                return
            end
            if key == Keymap.Throw then
                abilities:setActivated(AbilityType.Throw, isPressed)
            end
            if key == Keymap.Dash then
                abilities:setActivated(AbilityType.Dash, isPressed)
            end
            if key == Keymap.Left then
                movement.left = isPressed
                local ____ = isPressed and ((function(o, i, v)
                    o[i] = v
                    return v
                end)(movement, "direction", Direction.Left))
            end
            if key == Keymap.Right then
                movement.right = isPressed
                local ____ = isPressed and ((function(o, i, v)
                    o[i] = v
                    return v
                end)(movement, "direction", Direction.Right))
            end
            movement.jump = key == Keymap.Jump and isPressed and movement.jumpCount < 2
        end)
    end
end
InputSystem._id = "Input"
InputSystem._flag = SystemFlag.Input
InputSystem._aspect = Aspect.new({
    Input,
    Movement,
})
return ____exports
