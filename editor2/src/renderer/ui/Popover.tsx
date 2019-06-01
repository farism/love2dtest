import * as React from 'react'
import { popoverStyles } from './Popover.style'

interface IPopoverProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Popover = React.forwardRef<HTMLDivElement, IPopoverProps>(
  function Popover({ children, ...props }: IPopoverProps, ref) {
    const theme = {}

    const className = popoverStyles(theme)

    return (
      <div {...props} ref={ref} className={className.popover}>
        <span>{children}</span>
      </div>
    )
  }
)
