import * as React from "react";
import * as styles from "./Dialog.style";

interface DialogProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode;
}

export const Dialog = React.forwardRef<HTMLDivElement, DialogProps>(
  function Dialog({ children, ...props }: DialogProps, ref) {
    return (
      <div {...props} ref={ref} className={styles.dialog}>
        {children}
      </div>
    );
  }
);
