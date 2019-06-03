import * as React from "react";

interface CodeInlineProps {
  children: string;
  className?: string;
}

export function CodeInline({ children }: CodeInlineProps) {
  return <span>{children}</span>;
}
