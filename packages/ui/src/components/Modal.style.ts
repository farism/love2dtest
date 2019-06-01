import * as Typestyle from 'typestyle'

interface Theme {}

export function modalStyles(theme: Theme) {
  const selector = Typestyle.style({})

  return {
    modal: selector,
  }
}
