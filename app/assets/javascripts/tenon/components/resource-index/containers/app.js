import React, { Component, PropTypes } from 'react';
import Sidebar from '../components/sidebar';
import Record from '../components/record';
import * as Actions from '../actions';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';

class App extends Component {
  componentWillMount() {
    this.props.actions.fetchRecords(this.props.recordsPath);
  }

  render() {
    return(
      <div>
        <Sidebar
          records={this.props.records}
          title={this.props.title} />

        <div className="page-wrap">
          <header>
            <h1>{this.props.title}</h1>
            <div className="tools">
              <div className="header-button">
              </div>
            </div>
          </header>

          <div className="toolbox">
          </div>

          <div className="main-content">
            <ul className="record-list">
              {this.props.records.map((record, i) =>
                <Record {...record}
                  key={i}
                  onDelete={(e) => this._handleDelete(e, record)} />
              )}
            </ul>

            <a href="" className='btn btn-comp infinite-loader'>
              Load More Posts
            </a>
          </div>
        </div>
      </div>
    );
  }

  _handleDelete(e, record) {
    e.preventDefault();
    if (confirm('Are you sure?')) {
      this.props.actions.deleteRecord(record);
    }
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
