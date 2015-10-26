import React, { Component, PropTypes } from 'react';

export default class Record extends React.Component {
  render() {
    const { edit_path, title, delete_path, onDelete } = this.props;
    return (
      <li>
        <div className="record-details">
          <div className='record-actions'>
            <a href="#" onClick={onDelete} data-tooltip='Delete' title='Delete'>
              <i className="fa fa-trash"></i>
            </a>

            <a href={edit_path} data-tooltip="Edit" title="Edit">
              <i className="fa fa-pencil"></i>
            </a>
          </div>

          <div className="record-title">
            <a href={edit_path}>{title}</a>
          </div>
        </div>
      </li>
    )
  }
}
