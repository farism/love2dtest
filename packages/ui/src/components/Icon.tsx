import * as React from "react";
import * as styles from "./Icon.style";

interface IconProps extends React.HTMLAttributes<HTMLSpanElement> {
  children?: React.ReactNode;
}

export const Icon = React.forwardRef<HTMLSpanElement, IconProps>(function Icon(
  { children, ...props }: IconProps,
  ref
) {
  return (
    <span {...props} ref={ref} className={styles.icon}>
      {children}
    </span>
  );
});
