import * as React from 'react'
import { panelStyles } from './Panel.style'

interface IPanelProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Panel = React.forwardRef<HTMLDivElement, IPanelProps>(
  function Panel({ children, ...props }: IPanelProps, ref) {
    const theme = {}

    const className = panelStyles(theme)

    return (
      <div {...props} ref={ref} className={className.panel}>
        <span>{children}</span>
      </div>
    )
  }
)
