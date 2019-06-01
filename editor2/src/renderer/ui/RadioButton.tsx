import * as React from 'react'
import { radioButtonStyles } from './RadioButton.style'

interface IRadioButtonProps extends React.HTMLAttributes<HTMLInputElement> {
  children?: React.ReactNode
}

export const RadioButton = React.forwardRef<
  HTMLInputElement,
  IRadioButtonProps
>(function RadioButton({ children, ...props }: IRadioButtonProps, ref) {
  const theme = {}

  const className = radioButtonStyles(theme)

  return (
    <label className={className.radio}>
      <input {...props} ref={ref} type="radio" className={className.input} />
      <span className={className.label}>{children}</span>
    </label>
  )
})
