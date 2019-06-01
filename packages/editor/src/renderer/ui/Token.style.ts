import * as Typestyle from 'typestyle'

interface Theme {}

export function tokenStyles(theme: Theme) {
  const selector = Typestyle.style({})

  return {
    token: selector,
  }
}
