import { Component } from '../../ecs/component'
import { Entity } from '../../ecs/Entity'

const noop = () => {}

export const getEntity = (fixture: Fixture): Entity => {
  return fixture.getUserData().entity
}

export const hasComponent = (component: Component) => (fixture: Fixture) => {
  return getEntity(fixture).has(component)
}

export const hasComponents = (...components: Component[]) => (
  fixture: Fixture
) => {
  return components.every(component => hasComponent(component)(fixture))
}

export const isBodyType = (type: BodyType) => (fixture: Fixture) => {
  return fixture.getBody().getType() === type
}

export const isNotBodyType = (type: BodyType) => (fixture: Fixture) => {
  return !isBodyType(type)(fixture)
}
export const isSensor = (fixture: Fixture) => {
  return fixture.isSensor()
}

export const isNotSensor = (fixture: Fixture) => {
  return !isSensor(fixture)
}

export const check = (
  a: Fixture,
  b: Fixture,
  checks: [(fixture: Fixture) => boolean, (fixture: Fixture) => boolean]
) => {
  const check1 = checks[0] || noop
  const check2 = checks[1] || noop

  if (check1(a) && check2(b)) {
    return [getEntity(a), getEntity(b)]
  } else if (check1(b) && check2(a)) {
    return [getEntity(b), getEntity(a)]
  }

  return null
}
