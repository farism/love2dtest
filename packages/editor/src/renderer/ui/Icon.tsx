import * as React from 'react'
import { iconStyles } from './Icon.style'

interface IconProps extends React.HTMLAttributes<HTMLSpanElement> {
  children?: React.ReactNode
}

export const Icon = React.forwardRef<HTMLSpanElement, IconProps>(function Icon(
  { children, ...props }: IconProps,
  ref
) {
  const theme = {}

  const className = iconStyles(theme)

  return (
    <span {...props} ref={ref} className={className.icon}>
      {children}
    </span>
  )
})
