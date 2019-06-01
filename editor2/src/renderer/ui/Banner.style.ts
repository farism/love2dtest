import * as Typestyle from 'typestyle'

interface Theme {}

export function bannerStyles(theme: Theme) {
  const selector = Typestyle.style({})

  return {
    banner: selector,
  }
}
