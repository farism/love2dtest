import * as React from 'react'
import { tokenStyles } from './Token.style'

interface TokenProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Token = React.forwardRef<HTMLDivElement, TokenProps>(
  function Token({ children, ...props }: TokenProps, ref) {
    const theme = {}

    const className = tokenStyles(theme)

    return (
      <div {...props} ref={ref} className={className.token}>
        {children}
      </div>
    )
  }
)
