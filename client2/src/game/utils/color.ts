export type RGB = [number, number, number, number]

export const hexToRGB = (hex: string, alpha: number = 1): RGB => {
  return [
    tonumber(hex.slice(1, 3), 16) || 1,
    tonumber(hex.slice(3, 5), 16) || 1,
    tonumber(hex.slice(5, 7), 16) || 1,
    alpha,
  ]
}
