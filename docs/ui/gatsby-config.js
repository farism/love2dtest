const path = require('path')

module.exports = {
  siteMetadata: {
    title: '@icepicker/docs-ui',
    description: '',
    author: 'Faris Mustafa <farismmk@gmail.com>',
  },
  plugins: [
    'gatsby-plugin-typescript',
    'gatsby-plugin-react-helmet',
    'gatsby-transformer-sharp',
    'gatsby-plugin-sharp',
    {
      resolve: `gatsby-mdx`,
      options: {
        defaultLayouts: {
          default: path.resolve('./src/components/Layout.tsx'),
        },
        globalScope: `
          import * as UI from '@icepicker/ui'

          export default UI
        `,
      },
    },
    {
      resolve: `gatsby-source-filesystem`,
      options: {
        name: `images`,
        path: `${__dirname}/src/images`,
      },
    },
    {
      resolve: `gatsby-source-filesystem`,
      options: {
        name: `pages`,
        path: `${__dirname}/src/pages`,
      },
    },
  ],
}
