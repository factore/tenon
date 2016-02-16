import 'babel-core/polyfill';
import { Component } from 'react';
import { Provider } from 'react-redux';
import App from './app';
import configureStore from '../store/configure-store';

export default class Root extends Component {
  render() {
    return (
      <Provider store={configureStore()}>
        {() => <App {...this.props} />}
      </Provider>
    );
  }
}
