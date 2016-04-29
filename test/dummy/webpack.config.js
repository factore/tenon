const path = require('path');
require('coffee-script').register();
const babelSettings = {
  extends: path.join(__dirname, '/.babelrc')
}

module.exports = {
  entry: './client/application.js',
  output: {
    path: __dirname + '/dist',
    filename: 'bundle.js',
    publicPath: 'http://localhost:9999/',
    sourceMapFilename: '[file].map'
  },
  resolve: {
    extensions: ["", ".webpack.js", ".web.js", ".js", ".coffee"]
  },
  module: {
    loaders: [
      { test: /\.coffee$/, loader: 'coffee-loader' },
      {
        test: /\.js$/,
        // exclude: /node_modules/,
        loaders: ['react-hot', 'babel?' + JSON.stringify(babelSettings)],
        include: [
          path.join(__dirname, 'client'),
          path.join(__dirname, 'node_modules/tenon')
        ]
      },
      { test: /\.css$/, loader: 'style!css' },
      {
        test: /\.scss$/,
        loaders: ['style', 'css', 'sass']
      }
    ]
  },
  sassLoader: {
    includePaths: [
      ...require('tenon/stylesheets').includePaths,
      ...require('bourbon').includePaths
    ]
  },
  node: {
    fs: 'empty'
  }
};
