import * as React from "react";
import * as styles from "./Button.style";

interface ButtonProps extends React.HTMLAttributes<HTMLButtonElement> {
  children?: React.ReactNode;
}

export const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  function Button({ children, ...props }: ButtonProps, ref) {
    return (
      <button {...props} ref={ref} className={styles.button}>
        {children}
      </button>
    );
  }
);
