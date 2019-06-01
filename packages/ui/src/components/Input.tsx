import * as React from 'react'
import { inputStyles } from './Input.style'

interface InputProps extends React.HTMLAttributes<HTMLInputElement> {}

export const Input = React.forwardRef<HTMLInputElement, InputProps>(
  function Input({ ...props }: InputProps, ref) {
    const theme = {}

    const className = inputStyles(theme)

    return <input {...props} ref={ref} className={className.input} />
  }
)
