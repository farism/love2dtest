import * as Typestyle from 'typestyle'

interface Theme {}

export function panelStyles(theme: Theme) {
  const selector = Typestyle.style({
    border: '1px solid black',
  })

  return {
    panel: selector,
  }
}
