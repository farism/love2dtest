import * as React from 'react'
import { searchStyles } from './Search.style'

interface ISearchProps extends React.HTMLAttributes<HTMLInputElement> {
  children?: React.ReactNode
}

export const Search = React.forwardRef<HTMLInputElement, ISearchProps>(
  function Search({ children, ...props }: ISearchProps, ref) {
    const theme = {}

    const className = searchStyles(theme)

    return (
      <div className={className.search}>
        <input {...props} ref={ref}>
          <span>{children}</span>
        </input>
      </div>
    )
  }
)
