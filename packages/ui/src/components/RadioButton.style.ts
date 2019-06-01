import * as Typestyle from 'typestyle'

interface Theme {}

export function radioButtonStyles(theme: Theme) {
  const selector = Typestyle.style({
    display: 'inline-flex',
    alignItems: 'center',
    $nest: {
      '&__input': {
        opacity: 0,
        position: 'absolute',
      },
      '&__label': {
        display: 'inline-block',
        height: '16px',
        $nest: {
          '&::before': {
            background: 'white',
            content: `''`,
            display: 'inline-block',
            border: '1px solid black',
            width: '16px',
            height: '16px',
          },
        },
      },
    },
  })

  return {
    radio: selector,
    input: `${selector}__input`,
    label: `${selector}__label`,
  }
}
