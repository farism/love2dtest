import * as React from "react";
import * as styles from "./Toggle.style";

interface ToggleProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode;
}

export const Toggle = React.forwardRef<HTMLDivElement, ToggleProps>(
  function Toggle({ children, ...props }: ToggleProps, ref) {
    return (
      <div {...props} ref={ref} className={styles.toggle}>
        {children}
      </div>
    );
  }
);
