import * as Typestyle from 'typestyle'

interface Theme {}

export function tabsStyles(theme: Theme) {
  const selector = Typestyle.style({})

  return {
    tabs: selector,
  }
}
