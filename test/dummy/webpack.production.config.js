var webpack = require('webpack');
var config = require('./webpack.config');
const ExtractTextPlugin = require("extract-text-webpack-plugin");

module.exports = Object.assign({}, config, {
  plugins: config.plugins.concat([
    new ExtractTextPlugin("[name].css")
  ]),
  loaders: config.loaders.concat([
    {
      test: /\.scss$/,
      loader: ExtractTextPlugin.extract(
        'style-loader',
        'css-loader!sass-loader'
      )
    }
  ])
});
