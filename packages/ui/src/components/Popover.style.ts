import * as Typestyle from 'typestyle'

interface Theme {}

export function popoverStyles(theme: Theme) {
  const selector = Typestyle.style({})

  return {
    popover: selector,
  }
}
