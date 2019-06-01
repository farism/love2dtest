import * as React from 'react'
import { tokenStyles } from './Token.style'

interface ITokenProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Token = React.forwardRef<HTMLDivElement, ITokenProps>(
  function Token({ children, ...props }: ITokenProps, ref) {
    const theme = {}

    const className = tokenStyles(theme)

    return (
      <div {...props} ref={ref} className={className.token}>
        <span>{children}</span>
      </div>
    )
  }
)
