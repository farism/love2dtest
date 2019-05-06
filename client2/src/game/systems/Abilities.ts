import { Aspect } from '../../ecs/Aspect'
import { System } from '../../ecs/System'
import * as Timer from '../utils/timer'
import * as Factory from '../utils/factory'
import { SystemFlag } from '../flags'
import { GameObject } from '../components/GameObject'
import { Abilities, AbilityType, Ability } from '../components/Abilities'
import { Entity } from '../../ecs/Entity'
import { Movement, Direction } from '../components/Movement'
import { Position } from '../components/Position'
import { Dash } from '../components/Dash'
import { Damage } from '../components/Damage'

type AbilityList = {
  [key in AbilityType]: (entity: Entity, ability: Ability) => void
}

const abilityFunctions: AbilityList = {
  throw: (entity: Entity, ability: Ability) => {
    const movement = entity.as(Movement)
    const position = entity.as(Position)

    if (!movement || !position) {
      return
    }

    const x = position.x
    const y = position.y
    const projectile = Factory.createThrowingPick(entity, x, y)

    const gameObject = projectile.as(GameObject)

    if (gameObject) {
      const body = gameObject.fixture.getBody()

      if (movement.direction == Direction.Left) {
        body.setLinearVelocity(-1500, 0)
      } else {
        body.setLinearVelocity(1500, 0)
      }
    }
  },

  dash: (entity: Entity, ability: Ability) => {
    const gameObject = entity.as(GameObject)

    if (!gameObject) {
      return
    }

    gameObject.fixture.setCategory(3)

    entity.add(new Dash())
    entity.add(new Damage(1))

    ability.timers.duration = Timer.setTimeout(ability.duration, () => {
      gameObject.fixture.setCategory(2)

      entity.remove(Dash)
      entity.remove(Damage)
    })
  },

  ambush: (entity: Entity, ability: Ability) => {},

  grapple: (entity: Entity, ability: Ability) => {},

  dig: (entity: Entity, ability: Ability) => {},

  shoot: (entity: Entity, ability: Ability) => {},

  slash: (entity: Entity, ability: Ability) => {},

  stab: (entity: Entity, ability: Ability) => {},

  taser: (entity: Entity, ability: Ability) => {},
}

export class AbilitiesSystem extends System {
  static _id = 'Abilities'
  _id = AbilitiesSystem._id

  static _flag = SystemFlag.Abilities
  _flag = AbilitiesSystem._flag

  static _aspect = new Aspect([Abilities])
  _aspect = AbilitiesSystem._aspect

  update = (dt: number) => {
    this.entities.forEach(entity => {
      const abilities = entity.as(Abilities)

      if (!abilities) {
        return
      }

      for (let _key in abilities.abilities) {
        const key = _key as AbilityType
        const ability = abilities.abilities[key]

        if (ability.activated && !ability.timers.cooldown) {
          ability.timers.cooldown = Timer.setTimeout(ability.cooldown, () => {
            delete ability.timers.cooldown
          })

          Timer.clearTimeout(ability.timers.castspeed)

          ability.timers.castspeed = Timer.setTimeout(ability.castspeed, () => {
            delete ability.timers.castspeed

            abilityFunctions[key](entity, ability)
          })
        }
      }
    })
  }
}