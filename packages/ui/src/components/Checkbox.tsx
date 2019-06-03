import * as React from "react";
import * as styles from "./Checkbox.style";

interface CheckboxProps extends React.HTMLAttributes<HTMLInputElement> {
  children?: React.ReactNode;
}

export const Checkbox = React.forwardRef<HTMLInputElement, CheckboxProps>(
  function Checkbox({ children, ...props }: CheckboxProps, ref) {
    return (
      <label className={styles.checkbox}>
        <input {...props} ref={ref} type="checkbox" className={styles.input} />
        <span className={styles.label}>{children}</span>
      </label>
    );
  }
);
