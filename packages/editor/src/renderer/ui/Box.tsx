import * as React from 'react'
import { boxStyles } from './Box.style'

interface BoxProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Box = React.forwardRef<HTMLDivElement, BoxProps>(function Box(
  { children, ...props }: BoxProps,
  ref
) {
  const className = boxStyles({})

  return (
    <div {...props} ref={ref} className={className.box}>
      {children}
    </div>
  )
})
