import * as React from "react";
import * as styles from "./Anchor.style";

interface AnchorProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode;
}

export const Anchor = React.forwardRef<HTMLDivElement, AnchorProps>(
  function Anchor({ children, ...props }: AnchorProps, ref) {
    return (
      <div {...props} ref={ref} className={styles.anchor}>
        {children}
      </div>
    );
  }
);
