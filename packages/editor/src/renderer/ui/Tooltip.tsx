import * as React from 'react'
import { tooltipStyles } from './Tooltip.style'

interface TooltipProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Tooltip = React.forwardRef<HTMLDivElement, TooltipProps>(
  function Tooltip({ children, ...props }: TooltipProps, ref) {
    const theme = {}

    const className = tooltipStyles(theme)

    return (
      <div {...props} ref={ref} className={className.tooltip}>
        {children}
      </div>
    )
  }
)
