import * as ui from '@icepicker/ui'
import { MDXProvider } from '@mdx-js/react'
import { graphql } from 'gatsby'
import MDXRenderer from 'gatsby-mdx/mdx-renderer'
import React from 'react'
import { Code } from './Code'

const components = {
  code: Code(ui),
}

function PageTemplate({ data: { mdx }, ...props }) {
  return (
    <MDXProvider components={components}>
      <div>
        <h1>Title: {mdx.frontmatter.title}</h1>
        <h2>Stage: {mdx.frontmatter.stage}</h2>
        <MDXRenderer>{mdx.code.body}</MDXRenderer>
      </div>
    </MDXProvider>
  )
}

export const pageQuery = graphql`
  query MDXQuery($id: String) {
    mdx(id: { eq: $id }) {
      id
      frontmatter {
        slug
        title
        stage
      }
      code {
        body
      }
    }
  }
`
export default PageTemplate
