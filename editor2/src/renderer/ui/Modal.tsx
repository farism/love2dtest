import * as React from 'react'
import { modalStyles } from './Modal.style'

interface IModalProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Modal = React.forwardRef<HTMLDivElement, IModalProps>(
  function Modal({ children, ...props }: IModalProps, ref) {
    const className = modalStyles({})

    return (
      <div {...props} ref={ref} className={className.modal}>
        <span>{children}</span>
      </div>
    )
  }
)
