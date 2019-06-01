import * as React from 'react'
import { buttonStyles } from './Button.style'

interface ButtonProps extends React.HTMLAttributes<HTMLButtonElement> {
  children?: React.ReactNode
}

export const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  function Button({ children, ...props }: ButtonProps, ref) {
    const theme = {}

    const className = buttonStyles(theme)

    return (
      <button {...props} ref={ref} className={className.button}>
        {children}
      </button>
    )
  }
)
