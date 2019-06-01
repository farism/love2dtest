import * as Typestyle from 'typestyle'

interface Theme {}

export function toastStyles(theme: Theme) {
  const selector = Typestyle.style({})

  return {
    toast: selector,
  }
}
