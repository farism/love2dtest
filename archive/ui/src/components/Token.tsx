import * as React from "react";
import * as styles from "./Token.style";

interface TokenProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode;
}

export const Token = React.forwardRef<HTMLDivElement, TokenProps>(
  function Token({ children, ...props }: TokenProps, ref) {
    return (
      <div {...props} ref={ref} className={styles.token}>
        {children}
      </div>
    );
  }
);
