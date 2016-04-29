var webpack = require('webpack');
var config = require('./webpack.config');

module.exports = Object.assign({}, config, {
  entry: './client/application.js',
  devtool: 'eval-source-map',
  devServer: {
    port: 9999,
    inline: true,
    hot: true,
    proxy: {
      '*': 'http://localhost:3000'
    }
  },
  plugins: [
    new webpack.NoErrorsPlugin()
  ]
});
