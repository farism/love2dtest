import * as React from 'react'
import { linkStyles } from './Link.style'

interface LinkProps extends React.HTMLAttributes<HTMLAnchorElement> {
  children?: React.ReactNode
}

export const Link = React.forwardRef<HTMLAnchorElement, LinkProps>(
  function Link({ children, ...props }: LinkProps, ref) {
    const theme = {}

    const className = linkStyles(theme)

    return (
      <a {...props} ref={ref} className={className.link}>
        {children}
      </a>
    )
  }
)
