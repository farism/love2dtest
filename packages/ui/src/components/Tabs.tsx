import * as React from "react";
import * as styles from "./Tabs.style";

interface TabsProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode;
}

export const Tabs = React.forwardRef<HTMLDivElement, TabsProps>(function Tabs(
  { children, ...props }: TabsProps,
  ref
) {
  return (
    <div {...props} ref={ref} className={styles.tabs}>
      {children}
    </div>
  );
});
