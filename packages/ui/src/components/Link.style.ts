import * as Typestyle from 'typestyle'

interface Theme {}

export function linkStyles(theme: Theme) {
  const selector = Typestyle.style({
    color: 'blue',
  })

  return {
    link: selector,
  }
}
