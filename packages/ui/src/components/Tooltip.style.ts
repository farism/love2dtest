import * as Typestyle from 'typestyle'

interface Theme {}

export function tooltipStyles(theme: Theme) {
  const selector = Typestyle.style({})

  return {
    tooltip: selector,
  }
}
