import * as Typestyle from 'typestyle'

interface Theme {}

export function richTextStyles(theme: Theme) {
  const selector = Typestyle.style({})

  return {
    richText: selector,
  }
}
