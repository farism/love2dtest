const path = require('path')

const mode =
  process.env.NODE_ENV === 'production' ? 'production' : 'development'

module.exports = {
  mode,
  entry: {
    main: ['./src/index.ts'],
  },
  output: {
    path: path.resolve('dist'),
  },
  resolve: {
    extensions: ['.js', '.jsx', '.ts', '.tsx'],
  },
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          options: {
            cacheDirectory: true,
          },
        },
      },
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
