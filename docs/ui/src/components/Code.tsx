import { Language } from "prism-react-renderer";
import * as React from "react";
import { CodeLive } from "./CodeLive";
import { CodeStatic } from "./CodeStatic";

interface Scope {
  [k: string]: any;
}

interface CodeProps {
  children: string;
  className: string;
  inline?: string;
  live?: string;
  vertical?: string;
}

export function Code(scope: Scope) {
  return function Code({
    children,
    className,
    inline,
    live,
    vertical
  }: CodeProps) {
    const language = className.replace(/language-/, "");

    const props = {
      language: language as Language,
      scope
    };

    if (typeof live !== "undefined") {
      return (
        <CodeLive
          {...props}
          noInline={typeof inline === "undefined"}
          vertical={typeof vertical !== "undefined"}
        >
          {children}
        </CodeLive>
      );
    }

    return <CodeStatic {...props}>{children}</CodeStatic>;
  };
}
