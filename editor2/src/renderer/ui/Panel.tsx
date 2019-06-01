import * as React from 'react'
import { panelStyles } from './Panel.style'

interface PanelProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Panel = React.forwardRef<HTMLDivElement, PanelProps>(
  function Panel({ children, ...props }: PanelProps, ref) {
    const theme = {}

    const className = panelStyles(theme)

    return (
      <div {...props} ref={ref} className={className.panel}>
        {children}
      </div>
    )
  }
)
