import * as React from "react";
import * as styles from "./Search.style";

interface SearchProps extends React.HTMLAttributes<HTMLInputElement> {}

export const Search = React.forwardRef<HTMLInputElement, SearchProps>(
  function Search({ ...props }: SearchProps, ref) {
    return (
      <div className={styles.search}>
        <input {...props} ref={ref} />
      </div>
    );
  }
);
