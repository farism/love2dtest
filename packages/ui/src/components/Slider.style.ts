import * as Typestyle from 'typestyle'

interface Theme {}

export function sliderStyles(theme: Theme) {
  const selector = Typestyle.style({})

  return {
    slider: selector,
  }
}
