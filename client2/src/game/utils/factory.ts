import { WINDOW_HEIGHT, WINDOW_WIDTH } from '../../conf'
import { Entity } from '../../ecs/Entity'
import { Manager } from '../../ecs/Manager'
import { Abilities } from '../components/Abilities'
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
    new Abilities(),
    new GameObject(entity, fixture),
    new Health(),
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
  body.setFixedRotation(true)
  body.setGravityScale(0)
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
    new Health(1, 0),
    new Movement(),
    new Position(),
  ])

  return entity
}

export const createSlashMob = (initX: number = 0, initY: number = 0) => (
  manager: Manager
) => {
  const body = love.physics.newBody(manager.world, initX, initY, 'dynamic')
  const shape = love.physics.newRectangleShape(32, 32)
  const fixture = love.physics.newFixture(body, shape, 1)
  body.setFixedRotation(true)
  body.setMass(100)
  fixture.setCategory(Category.Enemy)

  const entity = manager.createEntity()
  entity.userData.blueprint = Blueprint.Mob
  entity.addAll([
    new GameObject(entity, fixture),
    new Health(1, 0),
    new Movement(),
    new Position(),
  ])

  return entity
}

export const createShieldMob = (initX: number = 0, initY: number = 0) => (
  manager: Manager
) => {
  const mob = createMob(initX, initY)(manager)
  const mobFixture = mob.as(GameObject).fixture
  const shield = createShield(initX, initY)(manager)
  const shieldFixture = shield.as(GameObject).fixture

  love.physics.newWeldJoint(
    mobFixture.getBody(),
    shieldFixture.getBody(),
    -24,
    0,
    0,
    0,
    false
  )

  mob.addAll([
    new Aggression(manager.world, mob, initX, initY, 300, 100, 5),
    new Waypoint(true, 50, [
      { x: initX },
      { x: initX - 200 },
      { x: initX + 300 },
    ]),
  ])

  return mob
}

const createShield = (initX: number, initY: number) => (manager: Manager) => {
  const body = love.physics.newBody(manager.world, initX, initY, 'dynamic')
  const shape = love.physics.newRectangleShape(24, 32)
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
    WINDOW_HEIGHT - 15,
    'static'
  )
  const shape = love.physics.newRectangleShape(WINDOW_WIDTH * 10, 30)
  const fixture = love.physics.newFixture(body, shape, 1)

  const entity = manager.createEntity()
  entity.userData = { blueprint: Blueprint.Ground }
  entity.addAll([new GameObject(entity, fixture)])

  return entity
}
