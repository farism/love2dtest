import { Component } from '../../ecs/Component'
import { Flag } from './flags'

export class Container {
  static _id = 'Container'
  _id = Container._id

  static _flag = Flag.Container
  _flag = Flag.Container

  constructor() {}
}
