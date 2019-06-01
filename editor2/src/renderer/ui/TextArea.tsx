import * as React from 'react'
import { textareaStyles } from './TextArea.style'

interface ITextAreaProps extends React.HTMLAttributes<HTMLTextAreaElement> {
  children?: React.ReactNode
}

export const TextArea = React.forwardRef<HTMLTextAreaElement, ITextAreaProps>(
  function TextArea({ children, ...props }: ITextAreaProps, ref) {
    const theme = {}

    const className = textareaStyles(theme)

    return (
      <textarea {...props} ref={ref} className={className.textarea}>
        <span>{children}</span>
      </textarea>
    )
  }
)
