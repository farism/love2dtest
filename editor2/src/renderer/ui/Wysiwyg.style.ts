import * as Typestyle from 'typestyle'

interface Theme {}

export function wyswiwygStyles(theme: Theme) {
  const selector = Typestyle.style({})

  return {
    wyswiwyg: selector,
  }
}
