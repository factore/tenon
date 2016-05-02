var webpack = require('webpack');
var config = require('./webpack.config');
const ExtractTextPlugin = require("extract-text-webpack-plugin");

module.exports = Object.assign({}, config, {
  output: {
    path: path.join(__dirname, 'client', 'build', 'assets'),
    publicPath: '/assets/',
    filename: '[name]-main.js',
    chunkFilename: '[id].chunk.[hash].js',
    sourceMapFilename: 'debugging/[file].map',
    pathinfo: false
  },
  module: {
    loaders: config.module.loaders.concat([
      {
        test: /\.scss$/,
        loader: ExtractTextPlugin.extract(
          'style-loader',
          'css-loader!sass-loader'
        )
      }
    ])
  },
  plugins: config.plugins.concat([
    new ExtractTextPlugin('[name]-main.css'),
    new webpack.optimize.DedupePlugin(),
    new webpack.optimize.UglifyJsPlugin(),
    new webpack.optimize.OccurenceOrderPlugin(),
    new webpack.optimize.AggressiveMergingPlugin(),
    new webpack.NoErrorsPlugin()
  ])
});
