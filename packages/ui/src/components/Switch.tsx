import * as React from 'react'
import { switchStyles } from './Switch.style'

interface SwitchProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Switch = React.forwardRef<HTMLDivElement, SwitchProps>(
  function Switch({ children, ...props }: SwitchProps, ref) {
    const className = switchStyles({})

    return (
      <div {...props} ref={ref} className={className.switch}>
        {children}
      </div>
    )
  }
)
