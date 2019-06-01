import * as React from 'react'
import { inputStyles } from './Input.style'

interface IInputProps extends React.HTMLAttributes<HTMLInputElement> {
  children?: React.ReactNode
}

export const Input = React.forwardRef<HTMLInputElement, IInputProps>(
  function Input({ children, ...props }: IInputProps, ref) {
    const theme = {}

    const className = inputStyles(theme)

    return (
      <input {...props} ref={ref} className={className.input}>
        <span>{children}</span>
      </input>
    )
  }
)
