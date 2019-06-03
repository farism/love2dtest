import * as React from "react";
import * as styles from "./Tooltip.style";

interface TooltipProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode;
}

export const Tooltip = React.forwardRef<HTMLDivElement, TooltipProps>(
  function Tooltip({ children, ...props }: TooltipProps, ref) {
    return (
      <div {...props} ref={ref} className={styles.tooltip}>
        {children}
      </div>
    );
  }
);
