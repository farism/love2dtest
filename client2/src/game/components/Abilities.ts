import { ComponentFlag } from '../flags'

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

interface AbilityProperties {
  cooldown: number
  duration: number
  castspeed: number
  enabled: boolean
  activated: boolean
  timers: object
}

const defineAbility = (
  cooldown = 0,
  duration = 0,
  castspeed = 0,
  enabled = true
): AbilityProperties => {
  return {
    cooldown: cooldown,
    duration: duration,
    castspeed: castspeed,
    enabled: enabled,
    activated: false,
    timers: {},
  }
}

export class Abilities {
  static _id = 'Abilities'
  _id = Abilities._id

  static _flag = ComponentFlag.Abilities
  _flag = ComponentFlag.Abilities

  abilities: { [k: string]: AbilityProperties }

  constructor() {
    this.abilities = {
      // player
      [AbilityType.Throw]: defineAbility(0.5, 0, 0),
      [AbilityType.Dash]: defineAbility(0.5, 0, 0),
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

  reset = () => {
    for (let key in this.abilities) {
      this.abilities[key].activated = false
      this.abilities[key].timers = {}
    }
  }

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
