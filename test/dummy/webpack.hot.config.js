var webpack = require('webpack');
var config = require('./webpack.config');

module.exports = Object.assign({}, config, {
  devtool: 'eval-source-map',

  output: {
    path: __dirname + '/dist',
    filename: '[name]-wp-bundle.js',
    publicPath: '/assets/',
    sourceMapFilename: '[file].map'
  },

  devServer: {
    port: 9999,
    inline: true,
    hot: true,
    proxy: {
      '*': 'http://localhost:3000'
    }
  },

  plugins: config.plugins.concat([
    new webpack.NoErrorsPlugin()
  ]),

  module: {
    loaders: config.module.loaders.concat([
      { test: /\.css$/, loader: 'style!css' },
      {
        test: /\.scss$/,
        loaders: ['style', 'css?sourceMap', 'sass?sourceMap']
      }
    ])
  }
});
