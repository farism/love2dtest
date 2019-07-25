import { graphql } from 'gatsby'
import * as React from 'react'
import { classes } from 'typestyle'
import { Content } from './Content'
import { SEO } from './SEO'
import { Sidebar } from './Sidebar'
import { page, pageContent, pageSidebar } from './styles'
import './styles.css'

export function Page({ data }: any) {
  return (
    <div className={classes(page)}>
      <SEO />
      <div className={classes(pageSidebar)}>
        <Sidebar />
      </div>
      <div className={classes(pageContent)}>
        <Content>{data.mdx.code.body}</Content>
      </div>
    </div>
  )
}

export const pageQuery = graphql`
  query PageQuery($id: String) {
    mdx(id: { eq: $id }) {
      id
      frontmatter {
        link
        title
      }
      code {
        body
      }
    }
  }
`

export default Page
