import { Flag } from './flags'

enum WaveType {
  Circular = 'circular',
  Horizontal = 'horizontal',
  Vertical = 'vertical',
}

export class Wave {
  static _id = 'Wave'
  _id = Wave._id

  static _flag = Flag.Wave
  _flag = Flag.Wave

  type: WaveType
  x: number
  y: number
  amplitude: number
  frequency: number
  direction: number

  constructor(
    type: WaveType = WaveType.Vertical,
    x: number = 0,
    y: number = 0,
    amplitude: number = 0,
    frequency: number = 0,
    direction: number = 0
  ) {
    this.type = type
    this.x = x
    this.y = y
    this.amplitude = amplitude
    this.frequency = frequency
    this.direction = direction
  }
}

export class CircularWave extends Wave {
  constructor(
    x: number = 0,
    y: number = 0,
    amplitude: number = 0,
    frequency: number = 0
  ) {
    super(WaveType.Circular, x, y, amplitude, frequency)
  }
}

export class HorizontalWave extends Wave {
  constructor(
    x: number = 0,
    y: number = 0,
    amplitude: number = 0,
    frequency: number = 0,
    direction: number = 1
  ) {
    super(WaveType.Horizontal, x, y, amplitude, frequency, direction)
  }
}

export class VerticalWave extends Wave {
  constructor(
    x: number = 0,
    y: number = 0,
    amplitude: number = 0,
    frequency: number = 0,
    direction: number = 1
  ) {
    super(WaveType.Vertical, x, y, amplitude, frequency, direction)
  }
}
