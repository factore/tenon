import React, { Component, PropTypes } from 'react';
import addons from 'react/addons'
import Record from '../components/record';

const ReactCSSTransitionGroup = React.addons.CSSTransitionGroup

export default class List extends Component {
  render() {
    return(
      <div className="main-content">
        <ul className="record-list">
          <ReactCSSTransitionGroup transitionName="record" transitionEnterTimeout={250} transitionLeaveTimeout={250} >
            {this.props.records.map((record, i) =>
              <Record {...record}
                key={i}
                onDelete={(e) => this._handleDelete(e, record)} />
            )}
          </ReactCSSTransitionGroup>
        </ul>

        <a href="" className='btn btn-comp infinite-loader'>
          Load More Posts
        </a>
      </div>
    )
  }

  _handleDelete(e, record) {
    e.preventDefault();
    if (confirm('Are you sure?')) {
      this.props.actions.deleteRecord(record);
    }
  }
}
