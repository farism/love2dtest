import * as Typestyle from 'typestyle'

interface Theme {}

export function inputStyles(theme: Theme) {
  const selector = Typestyle.style({})

  return {
    input: selector,
  }
}
