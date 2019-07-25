import * as React from "react";
import * as styles from "./Modal.style";

interface ModalProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode;
}

export const Modal = React.forwardRef<HTMLDivElement, ModalProps>(
  function Modal({ children, ...props }: ModalProps, ref) {
    return (
      <div {...props} ref={ref} className={styles.modal}>
        {children}
      </div>
    );
  }
);
