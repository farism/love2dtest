import { WINDOW_HEIGHT, WINDOW_WIDTH } from '../../conf'
import { Entity } from '../../ecs/Entity'
import { Manager } from '../../ecs/Manager'
import { Abilities } from '../components/Abilities'
import { Damage } from '../components/Damage'
import { GameObject } from '../components/GameObject'
import { Health } from '../components/Health'
import { Input } from '../components/Input'
import { Movement } from '../components/Movement'
import { Player } from '../components/Player'
import { Position } from '../components/Position'
import { Projectile } from '../components/Projectile'

export enum CollisionCategory {
  Static = 1,
  Player = 2,
  PlayerAttack = 3,
  Enemy = 4,
  EnemyAttack = 5,
  Container = 6,
  Bomb = 7,
  Aggression = 8,
}

export enum Blueprint {
  Ground = 'ground',
  Mob = 'mob',
  Player = 'player',
  Slope = 'slope',
  ThrowingPick = 'throwingPick',
  Icicle = 'icicle',
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
  fixture.setFriction(1)
  fixture.setCategory(CollisionCategory.Player)
  fixture.setMask(CollisionCategory.Enemy)

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
  fixture.setCategory(CollisionCategory.Static)

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

  if (origin.has(Player)) {
    fixture.setCategory(CollisionCategory.PlayerAttack)
    fixture.setMask(CollisionCategory.Player, CollisionCategory.Aggression)
  } else {
    fixture.setCategory(CollisionCategory.EnemyAttack)
    fixture.setMask(CollisionCategory.Enemy, CollisionCategory.Aggression)
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

export const createMob = (
  manager: Manager,
  initX: number = 0,
  initY: number = 0
) => {
  const body = love.physics.newBody(manager.world, initX, initY, 'dynamic')
  const shape = love.physics.newRectangleShape(32, 32)
  const fixture = love.physics.newFixture(body, shape, 1)
  body.setFixedRotation(true)
  fixture.setCategory(CollisionCategory.Enemy)

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

export const createSlashMob = (
  manager: Manager,
  initX: number = 0,
  initY: number = 0
) => {
  const body = love.physics.newBody(manager.world, initX, initY, 'dynamic')
  const shape = love.physics.newRectangleShape(32, 32)
  const fixture = love.physics.newFixture(body, shape, 1)
  body.setFixedRotation(true)
  fixture.setCategory(CollisionCategory.Enemy)

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
