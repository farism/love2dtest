import * as React from 'react'
import { richTextStyles } from './RichText.style'

interface RichTextProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const RichText = React.forwardRef<HTMLDivElement, RichTextProps>(
  function RichText({ children, ...props }: RichTextProps, ref) {
    const className = richTextStyles({})

    return (
      <div {...props} ref={ref} className={className.richText}>
        {children}
      </div>
    )
  }
)
