export type RGB = [number, number, number, number]

const toNumber = (str: string) => {
  const number = tonumber(str.length === 1 ? str + str : str, 16)

  return typeof number === 'undefined' ? 1 : number / 255
}

export const hexToRGB = (hex: string, alpha: number = 1): RGB => {
  const str = hex.replace('#', '')
  const len = str.length / 3

  return [
    toNumber(str.slice(0, len)),
    toNumber(str.slice(len, len * 2)),
    toNumber(str.slice(len * 2, len * 3)),
    alpha,
  ]
}
