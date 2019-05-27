import { Aspect } from '../../ecs/Aspect'
import { System } from '../../ecs/System'
import { Abilities, AbilityType } from '../components/Abilities'
import { Input } from '../components/Input'
import { Movement } from '../components/Movement'
import { SystemFlag } from '../flags'

enum Keymap {
  Left = 'a',
  Right = 'd',
  Jump = 'space',
  Throw = 'j',
  Dash = 'k',
}

export class InputSystem extends System {
  static _id = 'Input'
  _id = InputSystem._id

  static _flag = SystemFlag.Input
  _flag = InputSystem._flag

  static _aspect = new Aspect([Input, Movement])
  _aspect = InputSystem._aspect

  keyboard = (
    key: string,
    scancode: Scancode,
    isRepeat: boolean,
    isPressed: boolean
  ) => {
    this.entities.forEach(entity => {
      const abilities = entity.as<Abilities>(Abilities)
      const movement = entity.as<Movement>(Movement)

      if (!abilities || !movement) {
        return
      }

      if (key === Keymap.Throw) {
        abilities.setActivated(AbilityType.Throw, isPressed)
      }

      if (key === Keymap.Dash) {
        abilities.setActivated(AbilityType.Dash, isPressed)
      }

      if (key === Keymap.Left) {
        movement.left = isPressed

        isPressed && (movement.direction = 'left')
      }

      if (key === Keymap.Right) {
        movement.right = isPressed

        isPressed && (movement.direction = 'right')
      }

      movement.jump = key === Keymap.Jump && isPressed && movement.jumpCount < 2
    })
  }
}
