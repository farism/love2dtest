import Highlight, { defaultProps, Language } from 'prism-react-renderer'
import React from 'react'
import { LiveEditor, LiveError, LivePreview, LiveProvider } from 'react-live'

export function Code(scope: any) {
  return function Code({ children, className, live }) {
    const language = className.replace(/language-/, '') as Language

    if (live === 'true') {
      return (
        <div style={{ marginTop: '40px' }}>
          <LiveProvider code={children} scope={scope}>
            <LivePreview />
            <LiveEditor />
            <LiveError />
          </LiveProvider>
        </div>
      )
    }

    return (
      <Highlight {...defaultProps} code={children} language={language}>
        {({ className, style, tokens, getLineProps, getTokenProps }) => (
          <pre className={className} style={{ ...style, padding: '20px' }}>
            {tokens.map((line, i) => (
              <div key={i} {...getLineProps({ line, key: i })}>
                {line.map((token, key) => (
                  <span key={key} {...getTokenProps({ token, key })} />
                ))}
              </div>
            ))}
          </pre>
        )}
      </Highlight>
    )
  }
}
