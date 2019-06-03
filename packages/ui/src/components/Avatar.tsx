import * as React from "react";
import * as styles from "./Avatar.style";

interface AvatarProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode;
}

export const Avatar = React.forwardRef<HTMLDivElement, AvatarProps>(
  function Avatar({ children, ...props }: AvatarProps, ref) {
    return (
      <div {...props} ref={ref} className={styles.avatar}>
        {children}
      </div>
    );
  }
);
