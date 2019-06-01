import * as Typestyle from 'typestyle'

interface Theme {}

export function textareaStyles(theme: Theme) {
  const selector = Typestyle.style({})

  return {
    textarea: selector,
  }
}
