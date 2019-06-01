import * as React from 'react'
import { linkStyles } from './Link.style'

interface ILinkProps extends React.HTMLAttributes<HTMLAnchorElement> {
  children?: React.ReactNode
}

export const Link = React.forwardRef<HTMLAnchorElement, ILinkProps>(
  function Link({ children, ...props }: ILinkProps, ref) {
    const theme = {}

    const className = linkStyles(theme)

    return (
      <a {...props} ref={ref} className={className.link}>
        <span>{children}</span>
      </a>
    )
  }
)
