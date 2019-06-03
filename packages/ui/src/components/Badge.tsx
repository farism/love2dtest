import * as React from "react";
import * as styles from "./Badge.style";

interface BadgeProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode;
}

export const Badge = React.forwardRef<HTMLDivElement, BadgeProps>(
  function Badge({ children, ...props }: BadgeProps, ref) {
    return (
      <div {...props} ref={ref} className={styles.badge}>
        {children}
      </div>
    );
  }
);
