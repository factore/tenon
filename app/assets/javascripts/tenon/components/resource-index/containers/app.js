import React, { Component, PropTypes } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import * as Actions from '../actions';
import Sidebar from '../components/sidebar';
import Header from '../components/header'
import List from '../components/list'

class App extends Component {
  componentWillMount() {
    this.props.actions.setBaseUri(this.props.recordsPath);
    this.props.actions.fetchRecords();
  }

  render() {
    return(
      <div>
        <Sidebar
          records={this.props.records}
          title={this.props.title} />

        <div className="page-wrap">
          <Header
            title={this.props.title}
            searchAction={this.props.actions.quickSearchRecords} />

          <List {...this.props} />
        </div>
      </div>
    );
  }
}

App.defaultProps = {
  childComponents: {
    sidebar: 'Sidebar',
    header: 'Header',
    list: 'List',
    record: 'Record'
  }
}

function mapStateToProps(state) {
  return {...state };
}

function mapDispatchToProps(dispatch) {
  return {
    actions: bindActionCreators(Actions, dispatch)
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(App);
