if (module.hot) module.hot.accept();

require('./stylesheets/application.scss');
require('tenon');
require('./components/posts');
require('./components/post-categories');

$(() => {
  window.Tenon.init();
});
