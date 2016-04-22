if (module.hot) module.hot.accept();

require('./stylesheets/application.scss');
require('tenon');

$(() => {
  console.log('app init');
  window.Tenon.init();
});
