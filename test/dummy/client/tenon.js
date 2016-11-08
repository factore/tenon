if (module.hot) module.hot.accept();

require('./tenon.scss');
import Tenon from 'tenon-base';
window.Tenon = Tenon;

require('./components/posts');
require('./components/post-categories');

$(() => {
  window.Tenon.init();
});
