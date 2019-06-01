import * as Typestyle from 'typestyle'

interface Theme {}

export function badgeStyles(theme: Theme) {
  const selector = Typestyle.style({})

  return {
    badge: selector,
  }
}
