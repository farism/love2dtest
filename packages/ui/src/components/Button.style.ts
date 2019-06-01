import * as Typestyle from 'typestyle'

interface Theme {}

export function buttonStyles(theme: Theme) {
  const selector = Typestyle.style({
    display: 'inline-flex',
    alignItems: 'center',
    color: 'red',
    $nest: {
      '&__icon': {},
      '&__label': {},
    },
  })

  return {
    button: selector,
    icon: `${selector}__icon`,
    label: `${selector}__label`,
  }
}
