import * as Typestyle from 'typestyle'

interface Theme {}

export function spinnerStyles(theme: Theme) {
  const selector = Typestyle.style({})

  return {
    spinner: selector,
  }
}
