import * as React from "react";
import * as styles from "./TextArea.style";

interface TextAreaProps extends React.HTMLAttributes<HTMLTextAreaElement> {}

export const TextArea = React.forwardRef<HTMLTextAreaElement, TextAreaProps>(
  function TextArea({ ...props }: TextAreaProps, ref) {
    return <textarea {...props} ref={ref} className={styles.textarea} />;
  }
);
