import * as React from "react";
import * as styles from "./Progress.style";

interface ProgressProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode;
}

export const Progress = React.forwardRef<HTMLDivElement, ProgressProps>(
  function Progress({ children, ...props }: ProgressProps, ref) {
    return (
      <div {...props} ref={ref} className={styles.progress}>
        {children}
      </div>
    );
  }
);
