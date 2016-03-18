import 'babel-core/polyfill';
import { Component } from 'react';
import { Provider } from 'react-redux';
import Wrapper from './wrapper';
import StandaloneList from './standalone-list';
import configureStore from '../store/configure-store';

export default class Root extends Component {
  constructor(props, context) {
    super(props, context);
    this.store = configureStore();
  }

  render() {
    return (
      <Provider store={this.store}>
        {() => <Wrapper {...this.props}><StandaloneList /></Wrapper>}
      </Provider>
    );
  }
}
