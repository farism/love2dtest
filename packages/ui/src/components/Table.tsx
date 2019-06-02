import * as React from 'react'
import { tableStyles } from './Table.style'

interface TableProps extends React.HTMLAttributes<HTMLTableElement> {
  children?: React.ReactNode
}

export const Table = React.forwardRef<HTMLTableElement, TableProps>(
  function Table({ children, ...props }: TableProps, ref) {
    const theme = {}

    const className = tableStyles(theme)

    return (
      <table {...props} ref={ref} className={className.table}>
        {children}
      </table>
    )
  }
)
