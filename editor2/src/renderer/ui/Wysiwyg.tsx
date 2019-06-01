import * as React from 'react'
import { wyswiwygStyles } from './Wysiwyg.style'

interface IWyswiwygProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Wyswiwyg = React.forwardRef<HTMLDivElement, IWyswiwygProps>(
  function Wyswiwyg({ children, ...props }: IWyswiwygProps, ref) {
    const className = wyswiwygStyles({})

    return (
      <div {...props} ref={ref} className={className.wyswiwyg}>
        <span>{children}</span>
      </div>
    )
  }
)
