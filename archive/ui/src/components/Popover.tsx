import * as React from "react";
import * as styles from "./Popover.style";

interface PopoverProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode;
}

export const Popover = React.forwardRef<HTMLDivElement, PopoverProps>(
  function Popover({ children, ...props }: PopoverProps, ref) {
    return (
      <div {...props} ref={ref} className={styles.popover}>
        {children}
      </div>
    );
  }
);
