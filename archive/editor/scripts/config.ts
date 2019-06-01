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
    path: path.resolve('build/main'),
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
    renderer: ['./src/renderer/renderer.ts'],
  },
  output: {
    path: path.resolve('build/renderer'),
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
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: {
          loader: 'elm-webpack-loader',
          options: {
            // debug: true,
          },
        },
      },
      {
        test: /\.jsx?$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
        },
      },
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
