import * as React from "react";
import * as styles from "./Spinner.style";

interface SpinnerProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode;
}

export const Spinner = React.forwardRef<HTMLDivElement, SpinnerProps>(
  function Spinner({ children, ...props }: SpinnerProps, ref) {
    return (
      <div {...props} ref={ref} className={styles.spinner}>
        {children}
      </div>
    );
  }
);
