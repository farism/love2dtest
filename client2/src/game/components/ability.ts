import { Component } from '../../ecs/Component'
import { Flag } from './flags'

interface Ability {
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
): Ability => {
  return {
    cooldown: cooldown,
    duration: duration,
    castspeed: castspeed,
    enabled: enabled,
    activated: false,
    timers: {},
  }
}

export class Abilities extends Component {
  static _id = 'Abilities'
  _id = Abilities._id

  static _flag = Flag.Abilities
  _flag = Flag.Abilities

  abilities: { [k: string]: Ability }

  constructor() {
    super()

    this.abilities = {
      // player
      throw: defineAbility(0.5, 0, 0),
      dash: defineAbility(0.5, 0, 0),
      grapple: defineAbility(1, 0, 0),
      dig: defineAbility(1, 1, 0),

      // npc
      shoot: defineAbility(3, 0, 1.5, false),
      slash: defineAbility(3, 0, 1, false),
      stab: defineAbility(3, 0, 1, false),
      ambush: defineAbility(3, 0, 1, false),
      taser: defineAbility(3, 0, 1, false),
    }
  }

  reset = () => {
    for (let key in this.abilities) {
      this.abilities[key].activated = false
      this.abilities[key].timers = {}
    }
  }

  setCooldown = (ability: string, cooldown: number) => {
    this.abilities[ability].cooldown = cooldown
  }

  setDuration = (ability: string, duration: number) => {
    this.abilities[ability].duration = duration
  }

  setCastspeed = (ability: string, castspeed: number) => {
    this.abilities[ability].castspeed = castspeed
  }

  setEnabled = (ability: string, enabled: boolean) => {
    this.abilities[ability].enabled = enabled
  }

  setActivated = (ability: string, activated: boolean) => {
    this.abilities[ability].activated = activated
  }
}
