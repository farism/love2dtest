import * as React from 'react'
import { switchStyles } from './Switch.style'

interface ISwitchProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Switch = React.forwardRef<HTMLDivElement, ISwitchProps>(
  function Switch({ children, ...props }: ISwitchProps, ref) {
    const className = switchStyles({})

    return (
      <div {...props} ref={ref} className={className.switch}>
        <span>{children}</span>
      </div>
    )
  }
)
