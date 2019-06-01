import * as React from 'react'
import { tooltipStyles } from './Tooltip.style'

interface ITooltipProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Tooltip = React.forwardRef<HTMLDivElement, ITooltipProps>(
  function Tooltip({ children, ...props }: ITooltipProps, ref) {
    const theme = {}

    const className = tooltipStyles(theme)

    return (
      <div {...props} ref={ref} className={className.tooltip}>
        <span>{children}</span>
      </div>
    )
  }
)
