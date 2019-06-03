import * as React from "react";
import * as styles from "./RichText.style";

interface RichTextProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode;
}

export const RichText = React.forwardRef<HTMLDivElement, RichTextProps>(
  function RichText({ children, ...props }: RichTextProps, ref) {
    return (
      <div {...props} ref={ref} className={styles.richText}>
        {children}
      </div>
    );
  }
);
