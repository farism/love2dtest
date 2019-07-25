import * as React from 'react'
import { LiveEditor, LiveError, LivePreview, LiveProvider } from 'react-live'
import { CodeStaticProps } from './CodeStatic'

interface Scope {
  [k: string]: any
}

interface CodeLiveProps extends CodeStaticProps {
  noInline: boolean
  vertical: boolean
}

export function CodeLive({
  children,
  noInline,
  language,
  scope = {},
  vertical,
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
  )
}
