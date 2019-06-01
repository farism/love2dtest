import * as React from 'react'
import { spinnerStyles } from './Spinner.style'

interface SpinnerProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Spinner = React.forwardRef<HTMLDivElement, SpinnerProps>(
  function Spinner({ children, ...props }: SpinnerProps, ref) {
    const theme = {}

    const className = spinnerStyles(theme)

    return (
      <div {...props} ref={ref} className={className.spinner}>
        {children}
      </div>
    )
  }
)
