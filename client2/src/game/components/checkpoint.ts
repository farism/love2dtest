import { Component } from '../../ecs/Component'
import { Flag } from './flags'

export class Checkpoint {
  static _id = 'Checkpoint'
  _id = Checkpoint._id

  static _flag = Flag.Checkpoint
  _flag = Flag.Checkpoint

  index: number
  visited: boolean

  constructor(index: number = 1, visited: boolean = false) {
    this.index = index
    this.visited = visited
  }
}
