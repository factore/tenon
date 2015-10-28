import React, { Component, PropTypes } from 'react';

export default class LoadMoreButton extends Component {
  render() {
    const { title, loadAction, pagination } = this.props;
    let className = this._getClassName()
    return (
      <a href="#" onClick={loadAction} className={className}>
        Load More {title}
      </a>
    )
  }

  _getClassName() {
    let className = 'btn btn-comp infinite-loader';
    const pagination = this.props.pagination;
    if (pagination.totalPages > pagination.currentPage) {
      className += ' open'
    }
    return className;
  }
}
