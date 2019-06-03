import * as React from "react";
import * as styles from "./Table.style";

interface TableProps extends React.HTMLAttributes<HTMLTableElement> {
  children?: React.ReactNode;
}

export const Table = React.forwardRef<HTMLTableElement, TableProps>(
  function Table({ children, ...props }: TableProps, ref) {
    return (
      <table {...props} ref={ref} className={styles.table}>
        {children}
      </table>
    );
  }
);
