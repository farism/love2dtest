export interface Aliasable<T> {
  new (...args: any[]): T
  _id: string
  _flag: number
}
