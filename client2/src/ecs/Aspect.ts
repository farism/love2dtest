import { Component } from './Component'
import { Entity } from './Entity'

const flags = (components: Component[]): number => {
  let flags = 0

  components.forEach(cmp => {
    flags = bit.bxor(flags, cmp._flag)
  })

  return flags
}

export class Aspect {
  all: number
  none: number
  one: number

  constructor(
    all: Component[] = [],
    none: Component[] = [],
    one: Component[] = []
  ) {
    this.all = flags(all)
    this.none = flags(none)
    this.one = flags(one)
  }

  check = (entity: Entity): boolean => {
    const all = bit.bor(this.all, entity.components) === entity.components
    const none = bit.band(this.none, entity.components) === 0
    const one = bit.band(this.one, entity.components) !== 0

    return (one || all) && none
  }
}

export class AlwaysAspect extends Aspect {
  check = (_: any): boolean => {
    return true
  }
}

export class NeverAspect extends Aspect {
  check = (_: any): boolean => {
    return false
  }
}
