import 'babel-core/polyfill';
import { Component } from 'react';
import { Provider } from 'react-redux';
import App from './app';
import Wrapper from './wrapper';
import configureStore from '../store/configure-store';
import { updateQuery } from '../actions/data';

export default class Root extends Component {
  constructor(props, context) {
    super(props, context);
    this.store = configureStore();

    window.onpopstate = (e) => {
      if (e.state && e.state.query) {
        this.store.dispatch(updateQuery(e.state.query));
      }
    };
  }
  render() {
    return (
      <Provider store={this.store}>
        {() => <Wrapper {...this.props}><App /></Wrapper>}
      </Provider>
    );
  }
}
