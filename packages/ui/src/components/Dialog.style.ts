import * as Typestyle from 'typestyle'

interface Theme {}

export function dialogStyles(theme: Theme) {
  const selector = Typestyle.style({})

  return {
    dialog: selector,
  }
}
