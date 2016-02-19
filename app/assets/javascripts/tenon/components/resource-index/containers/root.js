import 'babel-core/polyfill';
import { Component } from 'react';
import { Provider } from 'react-redux';
import App from './app';
import configureStore from '../store/configure-store';
import { updateQuery } from '../actions/data';

const store = configureStore();

window.onpopstate = (e) => {
  if (e.state && e.state.query) {
    store.dispatch(updateQuery(e.state.query));
  }
};

export default class Root extends Component {
  render() {
    return (
      <Provider store={store}>
        {() => <App {...this.props} />}
      </Provider>
    );
  }
}
