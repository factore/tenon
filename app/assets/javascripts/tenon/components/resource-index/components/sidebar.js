import React, { Component, PropTypes } from 'react';

export default class Sidebar extends React.Component {
  render() {
    return(
      <div className="sidebar-container">
        <div className="sidebar">
          <div className="content">
            <h2>{this.props.title}</h2>
          </div>
        </div>
      </div>
    );
  }
}
