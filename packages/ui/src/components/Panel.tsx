import * as React from "react";
import * as styles from "./Panel.style";

interface PanelProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode;
}

export const Panel = React.forwardRef<HTMLDivElement, PanelProps>(
  function Panel({ children, ...props }: PanelProps, ref) {
    return (
      <div {...props} ref={ref} className={styles.panel}>
        {children}
      </div>
    );
  }
);
