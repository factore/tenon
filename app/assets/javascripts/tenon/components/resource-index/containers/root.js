import 'babel-core/polyfill';
import React, { Component } from 'react';
import { Provider } from 'react-redux';
import App from './app';
import configureStore from '../store/configure-store';

const store = configureStore();

export default class Root extends Component {
  render() {
    return(
      <Provider store={store}>
        {() => <App {...this.props} />}
      </Provider>
    );
  }
}
