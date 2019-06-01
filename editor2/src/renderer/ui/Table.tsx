import * as React from 'react'
import { tableStyles } from './Table.style'

interface ITableProps extends React.HTMLAttributes<HTMLTableElement> {
  children?: React.ReactNode
}

export const Table = React.forwardRef<HTMLTableElement, ITableProps>(
  function Table({ children, ...props }: ITableProps, ref) {
    const theme = {}

    const className = tableStyles(theme)

    return (
      <table {...props} ref={ref} className={className.table}>
        {children}
      </table>
    )
  }
)
