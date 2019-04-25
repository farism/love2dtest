import { WINDOW_WIDTH, WINDOW_HEIGHT } from '../conf'
import { Entity } from '../ecs/Entity'
import { Component } from '../ecs/Component'
import { GameObject } from './components/gameobject'
import { Player } from './components/player'
import { Position } from './components/position'
import { Input } from './components/input'
import { Health } from './components/health'
import { Abilities } from './components/ability'
import { Animation } from './components/animation'
import { Movement } from './components/movement'

interface Manager {
  world: World
  getNextId(): number
  addEntity(entity: Entity): void
  addComponent(entity: Entity, component: Component): void
  createEntity(id?: number, meta?: any): Entity
}

enum Category {
  Static = 1,
  Player = 2,
  PlayerAttack = 3,
  Enemy = 4,
  EnemyAttack = 5,
  Container = 6,
  Bomb = 7,
  Aggression = 8,
}

enum Blueprint {
  Ground = 'ground',
  Mob = 'mob',
  Slope = 'slope',
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
  fixture.setCategory(Category.Player)
  fixture.setMask(Category.Enemy)

  const entity = manager.createEntity()
  entity.userData = { blueprint: Blueprint.Ground }
  entity.addAll([
    // new Animation()
    new Abilities(),
    new GameObject(entity, fixture),
    new Health(),
    new Input(),
    // new Movement()
    new Player(),
    new Position(),
  ])
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
export const createSlashMob = (
  manager: Manager,
  initX: number = 0,
  initY: number = 0
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
