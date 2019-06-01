import * as Typestyle from 'typestyle'

interface Theme {}

export function avatarStyles(theme: Theme) {
  const selector = Typestyle.style({})

  return {
    avatar: selector,
  }
}
