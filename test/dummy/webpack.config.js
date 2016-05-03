const path = require('path');

require('coffee-script').register();
const babelSettings = {
  extends: path.join(__dirname, '/.babelrc')
}

module.exports = {
  entry: {
    app: './client/app',
    tenon: './client/tenon'
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
    ]
  },
  sassLoader: {
    includePaths: [
      ...require('tenon/stylesheets').includePaths,
      ...require('bourbon').includePaths
    ]
  },
  plugins: [],
  node: {
    fs: 'empty'
  }
};
