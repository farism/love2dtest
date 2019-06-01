import * as Typestyle from 'typestyle'

interface Theme {}

export function boxStyles(theme: Theme) {
  const selector = Typestyle.style({})

  return {
    box: selector,
  }
}
