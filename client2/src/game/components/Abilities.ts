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

const defineAbility = (
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

  abilities: { [key in AbilityType]: Ability }

  constructor() {
    this.abilities = {
      // player
      [AbilityType.Throw]: defineAbility(0.5, 0, 0),
      [AbilityType.Dash]: defineAbility(1, 0.2, 0),
      [AbilityType.Grapple]: defineAbility(1, 0, 0),
      [AbilityType.Dig]: defineAbility(1, 1, 0),

      // npc
      [AbilityType.Shoot]: defineAbility(3, 0, 1.5, false),
      [AbilityType.Slash]: defineAbility(3, 0, 1, false),
      [AbilityType.Stab]: defineAbility(3, 0, 1, false),
      [AbilityType.Ambush]: defineAbility(3, 0, 1, false),
      [AbilityType.Taser]: defineAbility(3, 0, 1, false),
    }
  }

  reset = () => {}

  setCooldown = (ability: AbilityType, cooldown: number) => {
    this.abilities[ability].cooldown = cooldown
  }

  setDuration = (ability: AbilityType, duration: number) => {
    this.abilities[ability].duration = duration
  }

  setCastspeed = (ability: AbilityType, castspeed: number) => {
    this.abilities[ability].castspeed = castspeed
  }

  setEnabled = (ability: AbilityType, enabled: boolean) => {
    this.abilities[ability].enabled = enabled
  }

  setActivated = (ability: AbilityType, activated: boolean) => {
    this.abilities[ability].activated = activated
  }
}
