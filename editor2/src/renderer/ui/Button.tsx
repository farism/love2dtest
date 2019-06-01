import * as React from 'react'
import { buttonStyles } from './Button.style'

interface IButtonProps extends React.HTMLAttributes<HTMLButtonElement> {
  children?: React.ReactNode
}

export const Button = React.forwardRef<HTMLButtonElement, IButtonProps>(
  function Button({ children, ...props }: IButtonProps, ref) {
    const theme = {}

    const className = buttonStyles(theme)

    return (
      <button {...props} ref={ref} className={className.button}>
        <span>{children}</span>
      </button>
    )
  }
)
