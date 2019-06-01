import * as React from 'react'
import { radioButtonStyles } from './RadioButton.style'

interface RadioButtonProps extends React.HTMLAttributes<HTMLInputElement> {
  children?: React.ReactNode
}

export const RadioButton = React.forwardRef<HTMLInputElement, RadioButtonProps>(
  function RadioButton({ children, ...props }: RadioButtonProps, ref) {
    const theme = {}

    const className = radioButtonStyles(theme)

    return (
      <label className={className.radio}>
        <input {...props} ref={ref} type="radio" className={className.input} />
        <span className={className.label}>{children}</span>
      </label>
    )
  }
)
