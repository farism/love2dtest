import { ComponentFlag } from '../flags'

export interface Point {
  x: number
  y: number
}

export class Waypoint {
  static _id = 'Waypoint'
  _id = Waypoint._id

  static _flag = ComponentFlag.Waypoint
  _flag = ComponentFlag.Waypoint

  active: boolean
  current: number
  speed: number
  path: Partial<Point>[]

  constructor(
    active: boolean = true,
    speed: number = 1,
    path: Partial<Point>[]
  ) {
    this.active = active
    this.current = 0
    this.speed = speed
    this.path = path
  }
}
