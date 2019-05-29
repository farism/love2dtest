import { WINDOW_HEIGHT, WINDOW_WIDTH } from '../../conf'
import { Entity } from '../../ecs/Entity'
import { Manager } from '../../ecs/Manager'
import { Abilities, AbilityType, defineAbility } from '../components/Abilities'
import { Aggression } from '../components/Aggression'
import { Damage } from '../components/Damage'
import { GameObject } from '../components/GameObject'
import { Health } from '../components/Health'
import { Input } from '../components/Input'
import { Movement } from '../components/Movement'
import { Parallax, ParallaxOptions } from '../components/Parallax'
import { Player } from '../components/Player'
import { Position } from '../components/Position'
import { Projectile } from '../components/Projectile'
import { Waypoint } from '../components/Waypoint'
import { Category } from './collision'

export enum Blueprint {
  Ground = 'ground',
  Mob = 'mob',
  Player = 'player',
  Slope = 'slope',
  ThrowingPick = 'throwingPick',
  Icicle = 'icicle',
  Shield = 'shield',
  Platform = 'platform',
}

export const createPlayer = (
  manager: Manager,
  initX: number = 0,
  initY: number = 0
) => {
  const body = love.physics.newBody(manager.world, initX, initY, 'dynamic')
  const shape = love.physics.newCircleShape(16)
  const fixture = love.physics.newFixture(body, shape, 1)
  body.setFixedRotation(true)
  body.setSleepingAllowed(false)
  fixture.setFriction(1)
  fixture.setCategory(Category.Player)
  fixture.setMask(Category.Enemy)

  const entity = manager.createEntity()
  entity.userData = { blueprint: Blueprint.Player }
  entity.addAll([
    // new Animation()
    new Abilities({
      [AbilityType.Throw]: defineAbility(0.5, 0, 0.2),
      [AbilityType.Dash]: defineAbility(1, 0.2, 0),
      // [AbilityType.Grapple]: defineAbility(1, 0, 0),
      // [AbilityType.Dig]: defineAbility(1, 1, 0),
    }),
    new GameObject(entity, fixture),
    new Health(10, 1),
    new Input(),
    new Movement(),
    new Player(),
    new Position(),
  ])

  return entity
}

export const createIcicle = (initX: number = 0, initY: number = 0) => (
  manager: Manager
) => {
  const body = love.physics.newBody(manager.world, initX, initY, 'static')
  const shape = love.physics.newRectangleShape(64, 64)
  const fixture = love.physics.newFixture(body, shape, 1)
  body.setFixedRotation(true)
  fixture.setCategory(Category.Static)

  const entity = manager.createEntity()
  entity.userData.blueprint = Blueprint.Icicle
  entity.addAll([new Damage(1), new GameObject(entity, fixture)])

  return entity
}

export const createThrowingPick = (
  origin: Entity,
  initX: number = 0,
  initY: number = 0
) => {
  const manager = origin.manager
  const body = love.physics.newBody(manager.world, initX, initY, 'dynamic')
  const shape = love.physics.newRectangleShape(8, 8)
  const fixture = love.physics.newFixture(body, shape, 1)
  body.setBullet(true)
  body.setFixedRotation(true)
  body.setGravityScale(0)
  body.setMass(0.0001)
  fixture.setFriction(1)
  fixture.setGroupIndex(-Category.Projectile)

  if (origin.has(Player)) {
    fixture.setCategory(Category.PlayerAttack)
    fixture.setMask(Category.Player, Category.Aggression)
  } else {
    fixture.setCategory(Category.EnemyAttack)
    fixture.setMask(Category.Enemy, Category.Aggression)
  }

  const entity = manager.createEntity()
  entity.userData = { blueprint: Blueprint.ThrowingPick }
  entity.addAll([
    new Damage(1),
    new GameObject(entity, fixture),
    new Position(),
    new Projectile(),
  ])

  return entity
}

export const createMob = (initX: number = 0, initY: number = 0) => (
  manager: Manager
) => {
  const body = love.physics.newBody(manager.world, initX, initY, 'dynamic')
  const shape = love.physics.newRectangleShape(32, 32)
  const fixture = love.physics.newFixture(body, shape, 1)
  body.setFixedRotation(true)
  fixture.setCategory(Category.Enemy)

  const entity = manager.createEntity()
  entity.userData.blueprint = Blueprint.Mob
  entity.addAll([
    new GameObject(entity, fixture),
    new Health(5, 0),
    new Movement(),
    new Position(),
  ])

  return entity
}

export const createSlashMob = (initX: number = 0, initY: number = 0) => (
  manager: Manager
) => {
  const mob = createMob(initX, initY)(manager)

  return mob
}

export const createShootMob = (initX: number = 0, initY: number = 0) => (
  manager: Manager
) => {
  const mob = createMob(initX, initY)(manager)

  mob.addAll([
    new Abilities({
      [AbilityType.Shoot]: defineAbility(5, 0, 2),
    }),
    new Aggression(manager.world, mob, initX, initY, 600, 32, 2, 300, 30),
  ])

  return mob
}

export const createShieldMob = (initX: number = 0, initY: number = 0) => (
  manager: Manager
) => {
  const mob = createMob(initX, initY)(manager)
  const shield = createShield(initX, initY)(manager)

  const mobGameObject = mob.as(GameObject)
  const shieldGameObject = shield.as(GameObject)

  if (!mobGameObject || !shieldGameObject) {
    return
  }

  love.physics.newWeldJoint(
    mobGameObject.fixture.getBody(),
    shieldGameObject.fixture.getBody(),
    -24,
    0,
    0,
    0,
    false
  )

  mob.addAll([
    new Aggression(manager.world, mob, initX, initY, 300, 64, 10, 50, 100),
    new Waypoint(true, 50, [
      { x: initX },
      { x: initX - 50 },
      { x: initX + 75 },
    ]),
  ])

  return mob
}

const createShield = (initX: number, initY: number) => (manager: Manager) => {
  const body = love.physics.newBody(manager.world, initX, initY, 'dynamic')
  const shape = love.physics.newRectangleShape(4, 32)
  const fixture = love.physics.newFixture(body, shape, 1)
  body.setFixedRotation(true)
  fixture.setCategory(Category.Enemy)

  const entity = manager.createEntity()
  entity.userData.blueprint = Blueprint.Shield
  entity.addAll([new GameObject(entity, fixture)])

  return entity
}

export const createSlope = (manager: Manager) => {
  const body = love.physics.newBody(manager.world, 1000, 0, 'static')
  const shape = love.physics.newPolygonShape(
    500,
    WINDOW_HEIGHT - 30,
    1500,
    WINDOW_HEIGHT - 130,
    1500,
    WINDOW_HEIGHT - 30
  )
  const fixture = love.physics.newFixture(body, shape, 1)

  const entity = manager.createEntity()
  entity.userData = { blueprint: Blueprint.Slope }
  entity.addAll([new GameObject(entity, fixture)])

  return entity
}

export const createParallax = (options: ParallaxOptions) => (
  manager: Manager
) => {
  const entity = manager.createEntity()
  entity.userData = { blueprint: Blueprint.Ground }
  entity.add(new Parallax(options))

  return entity
}

export const createGround = (manager: Manager) => {
  const body = love.physics.newBody(
    manager.world,
    WINDOW_WIDTH / 2,
    WINDOW_HEIGHT - 16,
    'static'
  )
  body.setGravityScale(0)
  const shape = love.physics.newRectangleShape(WINDOW_WIDTH * 10, 30)
  const fixture = love.physics.newFixture(body, shape, 1)

  const entity = manager.createEntity()
  entity.userData = { blueprint: Blueprint.Ground }
  entity.addAll([new GameObject(entity, fixture)])

  return entity
}

export const createPlatform = (
  x: number,
  y: number,
  width: number,
  height: number
) => (manager: Manager) => {
  const body = love.physics.newBody(manager.world, x, y, 'static')
  const shape = love.physics.newRectangleShape(width, height)
  const fixture = love.physics.newFixture(body, shape, 1)

  const entity = manager.createEntity()
  entity.userData = { blueprint: Blueprint.Platform }
  entity.addAll([new GameObject(entity, fixture)])

  return entity
}
