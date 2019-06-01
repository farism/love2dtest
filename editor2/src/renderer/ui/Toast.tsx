import * as React from 'react'
import { toastStyles } from './Toast.style'

interface IToastProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Toast = React.forwardRef<HTMLDivElement, IToastProps>(
  function Toast({ children, ...props }: IToastProps, ref) {
    const theme = {}

    const className = toastStyles(theme)

    return (
      <div {...props} ref={ref} className={className.toast}>
        <span>{children}</span>
      </div>
    )
  }
)
