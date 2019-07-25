import { graphql, Link, useStaticQuery } from 'gatsby'
import * as React from 'react'

interface Item {
  title: string
  link: string
  items: Item[]
}

interface MenuProps {
  item: Item
}

function Menu({ item }: MenuProps) {
  return (
    <li>
      <div>
        <Link to={item.link}>{item.title}</Link>
      </div>
      {item.items && item.items.length && (
        <ul>
          {item.items.map(item => (
            <Menu key={item.title} item={item} />
          ))}
        </ul>
      )}
    </li>
  )
}

export function Sidebar({}) {
  const { allMenuYaml } = useStaticQuery(graphql`
    query SidebarQuery {
      allMenuYaml {
        nodes {
          title
          link
          items {
            title
            link
            items {
              title
              link
            }
          }
        }
      }
    }
  `)

  return (
    <div>
      <ul>
        {allMenuYaml.nodes.map((item: Item) => {
          return <Menu key={item.title} item={item} />
        })}
      </ul>
    </div>
  )
}
