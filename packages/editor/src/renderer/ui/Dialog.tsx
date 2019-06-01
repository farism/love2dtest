import * as React from 'react'
import { dialogStyles } from './Dialog.style'

interface DialogProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Dialog = React.forwardRef<HTMLDivElement, DialogProps>(
  function Dialog({ children, ...props }: DialogProps, ref) {
    const className = dialogStyles({})

    return (
      <div {...props} ref={ref} className={className.dialog}>
        {children}
      </div>
    )
  }
)
