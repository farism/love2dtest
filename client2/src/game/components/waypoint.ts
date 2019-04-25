import { Flag } from './flags'

interface Point {
  x: number
  y: number
}

export class Waypoint {
  static _id = 'Waypoint'
  _id = Waypoint._id

  static _flag = Flag.Waypoint
  _flag = Flag.Waypoint

  active: boolean
  current: number
  speed: number
  path: Point[]

  constructor(active: boolean = true, speed: number = 1, path: Point[]) {
    this.active = active
    this.current = 1
    this.speed = speed
    this.path = path
  }
}
