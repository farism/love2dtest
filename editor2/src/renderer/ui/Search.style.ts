import * as Typestyle from 'typestyle'

interface Theme {}

export function searchStyles(theme: Theme) {
  const selector = Typestyle.style({})

  return {
    search: selector,
  }
}
