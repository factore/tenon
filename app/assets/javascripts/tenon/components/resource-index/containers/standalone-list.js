import { Component } from 'react';

export default class StandaloneList extends Component {
  render() {
    const { List } = this.props.childComponents;
    return (
      <div>
        <List {...this.props} />
      </div>
    );
  }
}
