import * as React from "react";
import * as styles from "./Slider.style";

interface SliderProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode;
}

export const Slider = React.forwardRef<HTMLDivElement, SliderProps>(
  function Slider({ children, ...props }: SliderProps, ref) {
    return (
      <div {...props} ref={ref} className={styles.slider}>
        {children}
      </div>
    );
  }
);
