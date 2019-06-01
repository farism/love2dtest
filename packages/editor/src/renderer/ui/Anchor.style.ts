import * as Typestyle from 'typestyle'

interface Theme {}

export function anchorStyles(theme: Theme) {
  const selector = Typestyle.style({})

  return {
    anchor: selector,
  }
}
