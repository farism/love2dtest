import * as React from "react";
import * as styles from "./Toast.style";

interface ToastProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode;
}

export const Toast = React.forwardRef<HTMLDivElement, ToastProps>(
  function Toast({ children, ...props }: ToastProps, ref) {
    return (
      <div {...props} ref={ref} className={styles.toast}>
        {children}
      </div>
    );
  }
);
