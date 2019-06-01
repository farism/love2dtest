import * as Typestyle from 'typestyle'

interface Theme {}

export function tableStyles(theme: Theme) {
  const selector = Typestyle.style({})

  return {
    table: selector,
  }
}
