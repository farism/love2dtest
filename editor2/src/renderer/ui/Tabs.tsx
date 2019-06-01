import * as React from 'react'
import { tabsStyles } from './Tabs.style'

interface ITabsProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Tabs = React.forwardRef<HTMLDivElement, ITabsProps>(function Tabs(
  { children, ...props }: ITabsProps,
  ref
) {
  const className = tabsStyles({})

  return (
    <div {...props} ref={ref} className={className.tabs}>
      <span>{children}</span>
    </div>
  )
})
