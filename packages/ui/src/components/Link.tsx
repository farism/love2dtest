import * as React from "react";
import * as styles from "./Link.style";

interface LinkProps extends React.HTMLAttributes<HTMLAnchorElement> {
  children?: React.ReactNode;
}

export const Link = React.forwardRef<HTMLAnchorElement, LinkProps>(
  function Link({ children, ...props }: LinkProps, ref) {
    return (
      <a {...props} ref={ref} className={styles.link}>
        {children}foo
      </a>
    );
  }
);
