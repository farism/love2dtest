import * as React from 'react'
import { progressStyles } from './Progress.style'

interface ProgressProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Progress = React.forwardRef<HTMLDivElement, ProgressProps>(
  function Progress({ children, ...props }: ProgressProps, ref) {
    const className = progressStyles({})

    return (
      <div {...props} ref={ref} className={className.progress}>
        {children}
      </div>
    )
  }
)
