import * as UI from '@icepicker/ui'
import { Link } from 'gatsby'
import * as React from 'react'
import { Code } from './Code'
import { SEO } from './SEO'
const { MDXProvider } = require('@mdx-js/react')
const MDXRenderer = require('gatsby-mdx/mdx-renderer')

interface ContentProps {
  children: string
  scope?: any
}

const components = {
  code: Code(UI),
  Link,
  SEO,
}

export function Content({ children }: ContentProps) {
  return (
    <div>
      <MDXProvider components={components}>
        <MDXRenderer>{children}</MDXRenderer>
      </MDXProvider>
    </div>
  )
}
