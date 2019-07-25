import * as React from "react";
import * as styles from "./Box.style";

interface BoxProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode;
}

export const Box = React.forwardRef<HTMLDivElement, BoxProps>(function Box(
  { children, ...props }: BoxProps,
  ref
) {
  return (
    <div {...props} ref={ref} className={styles.box}>
      {children}
    </div>
  );
});
