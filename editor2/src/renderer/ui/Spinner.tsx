import * as React from 'react'
import { spinnerStyles } from './Spinner.style'

interface ISpinnerProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Spinner = React.forwardRef<HTMLDivElement, ISpinnerProps>(
  function Spinner({ children, ...props }: ISpinnerProps, ref) {
    const theme = {}

    const className = spinnerStyles(theme)

    return (
      <div {...props} ref={ref} className={className.spinner}>
        <span>{children}</span>
      </div>
    )
  }
)
