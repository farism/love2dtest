import * as React from 'react'
import { modalStyles } from './Modal.style'

interface ModalProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Modal = React.forwardRef<HTMLDivElement, ModalProps>(
  function Modal({ children, ...props }: ModalProps, ref) {
    const className = modalStyles({})

    return (
      <div {...props} ref={ref} className={className.modal}>
        {children}
      </div>
    )
  }
)
