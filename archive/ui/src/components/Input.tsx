import * as React from "react";
import * as styles from "./Input.style";

interface InputProps extends React.HTMLAttributes<HTMLInputElement> {}

export const Input = React.forwardRef<HTMLInputElement, InputProps>(
  function Input({ ...props }: InputProps, ref) {
    return <input {...props} ref={ref} className={styles.input} />;
  }
);
