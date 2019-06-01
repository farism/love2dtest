import * as Typestyle from 'typestyle'

interface Theme {}

export function iconStyles(theme: Theme) {
  const selector = Typestyle.style({})

  return {
    icon: selector,
  }
}
