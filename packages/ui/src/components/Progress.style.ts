import * as Typestyle from 'typestyle'

interface Theme {}

export function progressStyles(theme: Theme) {
  const selector = Typestyle.style({})

  return {
    progress: selector,
  }
}
