import * as path from 'path'
import { Configuration } from 'webpack'
const HtmlWebpackPlugin = require('html-webpack-plugin')

const mode =
  process.env.NODE_ENV === 'production' ? 'production' : 'development'

export const mainConfig: Configuration = {
  mode,
  target: 'electron-main',
  entry: {
    main: ['./src/main/main.ts'],
  },
  output: {
    path: path.resolve('dist/main'),
  },
  resolve: {
    extensions: ['.js', '.jsx', '.ts', '.tsx'],
  },
  externals: {
    'aws-sdk': 'empty',
    fsevents: 'empty',
  },
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        exclude: /node_modules/,
        use: {
          loader: 'ts-loader',
        },
      },
    ],
  },
}

export const rendererConfig: Configuration = {
  mode,
  target: 'electron-renderer',
  entry: {
    renderer: ['./src/renderer/renderer.tsx'],
  },
  output: {
    path: path.resolve('dist/renderer'),
  },
  resolve: {
    extensions: ['.js', '.jsx', '.ts', '.tsx', '.elm'],
  },
  externals: {
    'aws-sdk': 'empty',
    fsevents: 'empty',
  },
  module: {
    rules: [
      {
        test: /\.tsx?$/,
        exclude: /node_modules/,
        use: {
          loader: 'ts-loader',
        },
      },
      {
        test: /\.css$/,
        loader: ['style-loader', 'css-loader'],
      },
    ],
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: 'src/renderer/index.html',
    }),
  ],
}
