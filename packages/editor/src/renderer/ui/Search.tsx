import * as React from 'react'
import { searchStyles } from './Search.style'

interface SearchProps extends React.HTMLAttributes<HTMLInputElement> {}

export const Search = React.forwardRef<HTMLInputElement, SearchProps>(
  function Search({ ...props }: SearchProps, ref) {
    const theme = {}

    const className = searchStyles(theme)

    return (
      <div className={className.search}>
        <input {...props} ref={ref} />
      </div>
    )
  }
)
