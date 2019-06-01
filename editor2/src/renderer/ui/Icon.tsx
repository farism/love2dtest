import * as React from 'react'
import { iconStyles } from './Icon.style'

interface IIconProps extends React.HTMLAttributes<HTMLSpanElement> {
  children?: React.ReactNode
}

export const Icon = React.forwardRef<HTMLSpanElement, IIconProps>(function Icon(
  { children, ...props }: IIconProps,
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
