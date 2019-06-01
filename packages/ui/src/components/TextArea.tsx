import * as React from 'react'
import { textareaStyles } from './TextArea.style'

interface TextAreaProps extends React.HTMLAttributes<HTMLTextAreaElement> {}

export const TextArea = React.forwardRef<HTMLTextAreaElement, TextAreaProps>(
  function TextArea({ ...props }: TextAreaProps, ref) {
    const theme = {}

    const className = textareaStyles(theme)

    return <textarea {...props} ref={ref} className={className.textarea} />
  }
)
