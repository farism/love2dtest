import * as React from "react";
import * as styles from "./Banner.style";

interface BannerProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode;
}

export const Banner = React.forwardRef<HTMLDivElement, BannerProps>(
  function Banner({ children, ...props }: BannerProps, ref) {
    return (
      <div {...props} ref={ref} className={styles.banner}>
        {children}
      </div>
    );
  }
);
