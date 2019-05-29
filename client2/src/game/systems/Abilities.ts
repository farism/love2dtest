import { Aspect } from '../../ecs/Aspect'
import { Entity } from '../../ecs/Entity'
import { System } from '../../ecs/System'
import { Abilities, Ability, AbilityType } from '../components/Abilities'
import { Dash } from '../components/Dash'
import { GameObject } from '../components/GameObject'
import { Health } from '../components/Health'
import { Movement } from '../components/Movement'
import { Position } from '../components/Position'
import { SystemFlag } from '../flags'
import { hexToRGB, RGB } from '../utils/color'
import * as Factory from '../utils/factory'
import * as Timer from '../utils/timer'

type AbilityList = {
  [key in AbilityType]: (entity: Entity, ability: Ability) => void
}

const progress = (
  x: number,
  y: number,
  width: number,
  height: number,
  progress: number,
  fill: RGB
) => {
  const color = love.graphics.getColor()

  // print(progress)

  love.graphics.rectangle('fill', x - width / 2, y - height / 2, width, height)
  love.graphics.setColor(...fill)
  love.graphics.rectangle(
    'fill',
    x + 1 - width / 2,
    y + 1 - height / 2,
    Math.max(0, progress * width - 2),
    Math.max(0, height - 2)
  )
  love.graphics.setColor(color)
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

      if (movement.direction == 'left') {
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
    // entity.add(new Damage(1))

    ability.timers.duration = Timer.createTimer(ability.duration, () => {
      gameObject.fixture.setCategory(2)

      entity.remove(Dash)
      // entity.remove(Damage)
    })
  },

  ambush: (entity: Entity, ability: Ability) => {},

  grapple: (entity: Entity, ability: Ability) => {},

  dig: (entity: Entity, ability: Ability) => {},

  shoot: (entity: Entity, ability: Ability) => {
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

      if (movement.direction == 'left') {
        body.setLinearVelocity(-1500, 0)
      } else {
        body.setLinearVelocity(1500, 0)
      }
    }
  },

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

      Object.keys(abilities.abilities).forEach(_key => {
        const key = _key as AbilityType
        const ability = abilities.abilities[key]

        if (!ability || !ability.activated || !ability.enabled) {
          return
        }

        if (ability.timers.castspeed) {
          ability.timers.castspeed.kill()
        }

        ability.enabled = false

        ability.timers.castspeed = Timer.createTimer(ability.castspeed, () => {
          ability.timers.cooldown = Timer.createTimer(ability.cooldown, () => {
            ability.enabled = true
            print('cooldown completed')
          })

          abilityFunctions[key](entity, ability)
        })
      })
    })
  }

  draw = () => {
    this.entities.forEach(entity => {
      const abilities = entity.as(Abilities)
      const position = entity.as(Position)
      const health = entity.as(Health)

      if (!abilities || !position) {
        return
      }

      const offset = { x: 0, y: 0 }

      Object.values(abilities.abilities).forEach(ability => {
        if (ability) {
          offset.y += 11
          progress(
            position.x,
            position.y - offset.y,
            100,
            10,
            ability.timers.castspeed.currentPercent,
            hexToRGB('#0f0')
          )

          offset.y += 11
          progress(
            position.x,
            position.y - offset.y,
            100,
            10,
            ability.timers.cooldown.currentPercent,
            hexToRGB('#f00')
          )
        }
      })

      const hpPercent = health ? health.hitpoints / 10 : 0

      offset.y += 11
      progress(
        position.x,
        position.y - offset.y,
        100,
        10,
        hpPercent,
        hexToRGB('#00f')
      )
    })
  }
}
