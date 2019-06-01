import * as React from 'react'
import { popoverStyles } from './Popover.style'

interface PopoverProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Popover = React.forwardRef<HTMLDivElement, PopoverProps>(
  function Popover({ children, ...props }: PopoverProps, ref) {
    const theme = {}

    const className = popoverStyles(theme)

    return (
      <div {...props} ref={ref} className={className.popover}>
        {children}
      </div>
    )
  }
)
