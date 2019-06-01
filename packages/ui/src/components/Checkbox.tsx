import * as React from 'react'
import { checkboxStyles } from './Checkbox.style'

interface CheckboxProps extends React.HTMLAttributes<HTMLInputElement> {
  children?: React.ReactNode
}

export const Checkbox = React.forwardRef<HTMLInputElement, CheckboxProps>(
  function Checkbox({ children, ...props }: CheckboxProps, ref) {
    const theme = {}

    const className = checkboxStyles(theme)

    return (
      <label className={className.checkbox}>
        <input
          {...props}
          ref={ref}
          type="checkbox"
          className={className.input}
        />
        <span className={className.label}>{children}</span>
      </label>
    )
  }
)
