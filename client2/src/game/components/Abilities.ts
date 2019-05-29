import { ComponentFlag } from '../flags'
import { createTimer, Timer } from '../utils/timer'

const emptyTimer = createTimer(0, () => {})

export enum AbilityType {
  Throw = 'throw',
  Dash = 'dash',
  Grapple = 'grapple',
  Dig = 'dig',
  Shoot = 'shoot',
  Slash = 'slash',
  Stab = 'stab',
  Ambush = 'ambush',
  Taser = 'taser',
}

export interface Ability {
  activated: boolean
  castspeed: number
  cooldown: number
  duration: number
  enabled: boolean
  timers: {
    castspeed: Timer
    cooldown: Timer
    duration: Timer
  }
}

export type AbilitiesMap = { [key in AbilityType]?: Ability }

export const defineAbility = (
  cooldown = 0,
  duration = 0,
  castspeed = 0,
  enabled = true
): Ability => {
  return {
    activated: false,
    castspeed: castspeed,
    cooldown: cooldown,
    duration: duration,
    enabled: enabled,
    timers: {
      castspeed: emptyTimer,
      cooldown: emptyTimer,
      duration: emptyTimer,
    },
  }
}

export class Abilities {
  static _id = 'Abilities'
  _id = Abilities._id

  static _flag = ComponentFlag.Abilities
  _flag = ComponentFlag.Abilities

  abilities: AbilitiesMap

  constructor(abilities: AbilitiesMap) {
    this.abilities = abilities
  }

  setActivated = (abilityType: AbilityType, activated: boolean) => {
    const ability = this.abilities[abilityType]

    ability && (ability.activated = activated)
  }

  reset = () => {}
}
