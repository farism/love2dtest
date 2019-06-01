import * as React from 'react'
import { tabsStyles } from './Tabs.style'

interface TabsProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Tabs = React.forwardRef<HTMLDivElement, TabsProps>(function Tabs(
  { children, ...props }: TabsProps,
  ref
) {
  const className = tabsStyles({})

  return (
    <div {...props} ref={ref} className={className.tabs}>
      {children}
    </div>
  )
})
