import * as React from 'react'
import { toastStyles } from './Toast.style'

interface ToastProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Toast = React.forwardRef<HTMLDivElement, ToastProps>(
  function Toast({ children, ...props }: ToastProps, ref) {
    const theme = {}

    const className = toastStyles(theme)

    return (
      <div {...props} ref={ref} className={className.toast}>
        {children}
      </div>
    )
  }
)
