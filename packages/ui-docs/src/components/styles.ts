import 'normalize.css'
import 'reset-css'
import { style } from 'typestyle'

export const page = style({
  display: 'flex',
})

export const pageSidebar = style({
  flexShrink: 0,
  height: '100%',
  width: 250,
  background: 'red',

  $nest: {
    [`.${page} &`]: {
      background: 'blue',
    },
  },
})

export const pageContent = style({
  flexGrow: 1,
  height: '100%',
})

export const select = style({
  $debugName: 'select',
  background: 'black',
})
