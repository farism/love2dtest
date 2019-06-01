import * as React from 'react'
import { anchorStyles } from './Anchor.style'

interface AnchorProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Anchor = React.forwardRef<HTMLDivElement, AnchorProps>(
  function Anchor({ children, ...props }: AnchorProps, ref) {
    const className = anchorStyles({})

    return (
      <div {...props} ref={ref} className={className.anchor}>
        {children}
      </div>
    )
  }
)
