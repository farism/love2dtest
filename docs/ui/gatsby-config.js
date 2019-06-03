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
    'gatsby-plugin-sharp',
    'gatsby-transformer-sharp',
    'gatsby-transformer-yaml',
    {
      resolve: 'gatsby-source-filesystem',
      options: {
        name: 'images',
        path: './src/images',
      },
    },
    {
      resolve: 'gatsby-source-filesystem',
      options: {
        name: 'components',
        path: './src/content',
      },
    },
    {
      resolve: 'gatsby-source-filesystem',
      options: {
        name: 'data',
        path: './src/data',
      },
    },
    {
      resolve: 'gatsby-mdx',
      options: {
        gatsbyRemarkPlugins: ['gatsby-remark-autolink-headers'],
      },
    },
    {
      resolve: 'gatsby-plugin-web-font-loader',
      options: {
        google: {
          families: ['Roboto'],
        },
      },
    },
  ],
}
