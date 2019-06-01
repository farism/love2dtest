import * as React from 'react'
import { wyswiwygStyles } from './Wysiwyg.style'

interface WyswiwygProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Wyswiwyg = React.forwardRef<HTMLDivElement, WyswiwygProps>(
  function Wyswiwyg({ children, ...props }: WyswiwygProps, ref) {
    const className = wyswiwygStyles({})

    return (
      <div {...props} ref={ref} className={className.wyswiwyg}>
        {children}
      </div>
    )
  }
)
