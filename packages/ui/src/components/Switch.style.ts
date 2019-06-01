import * as Typestyle from 'typestyle'

interface Theme {}

export function switchStyles(theme: Theme) {
  const selector = Typestyle.style({})

  return {
    switch: selector,
  }
}
