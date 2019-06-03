import { Language } from 'prism-react-renderer'
import * as React from 'react'
import { LiveEditor, LiveProvider } from 'react-live'

interface Scope {
  [k: string]: any
}

export interface CodeStaticProps {
  children: string
  className?: string
  language: Language
  scope?: Scope
}

export function CodeStatic({ children, language }: CodeStaticProps) {
  return (
    <LiveProvider disabled code={children.trim()} language={language}>
      <LiveEditor />
    </LiveProvider>
  )
}
