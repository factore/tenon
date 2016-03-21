import { Component } from 'react';

export default class StandaloneList extends Component {
  componentWillMount() {
    this.props.actions.updateConfig({
      manageQueryString: false,
      baseUri: this.props.recordsPath,
      reorderUri: this.props.reorderPath
    });

    this.props.actions.fetchRecords();
  }
  render() {
    const { List } = this.props.childComponents;

    return (
      <div>
        <List {...this.props} />
      </div>
    );
  }
}
