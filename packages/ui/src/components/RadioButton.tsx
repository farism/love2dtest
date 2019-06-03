import * as React from "react";
import * as styles from "./RadioButton.style";

interface RadioButtonProps extends React.HTMLAttributes<HTMLInputElement> {
  children?: React.ReactNode;
}

export const RadioButton = React.forwardRef<HTMLInputElement, RadioButtonProps>(
  function RadioButton({ children, ...props }: RadioButtonProps, ref) {
    return (
      <label className={styles.radio}>
        <input {...props} ref={ref} type="radio" className={styles.input} />
        <span className={styles.label}>{children}</span>
      </label>
    );
  }
);
