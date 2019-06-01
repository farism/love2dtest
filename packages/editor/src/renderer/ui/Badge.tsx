import * as React from 'react'
import { badgeStyles } from './Badge.style'

interface BadgeProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Badge = React.forwardRef<HTMLDivElement, BadgeProps>(
  function Badge({ children, ...props }: BadgeProps, ref) {
    const className = badgeStyles({})

    return (
      <div {...props} ref={ref} className={className.badge}>
        {children}
      </div>
    )
  }
)
