import { Language } from "prism-react-renderer";
import * as React from "react";
import { LiveEditor, LiveError, LivePreview, LiveProvider } from "react-live";

interface Scope {
  [k: string]: any;
}

interface CodeLiveProps {
  children: string;
  className?: string;
  language: Language;
  noInline: boolean;
  scope?: Scope;
  vertical: boolean;
}

export function CodeLive({
  children,
  noInline,
  language,
  scope = {},
  vertical
}: CodeLiveProps) {
  return (
    <LiveProvider
      code={children.trim()}
      language={language}
      noInline={noInline}
      scope={scope}
    >
      <LiveEditor />
      <LivePreview />
      <LiveError />
    </LiveProvider>
  );
}
