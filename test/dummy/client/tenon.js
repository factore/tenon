if (module.hot) module.hot.accept();

require('./tenon.scss')
require('tenon');
require('./components/posts');
require('./components/post-categories');

$(() => {
  window.Tenon.init();
});
