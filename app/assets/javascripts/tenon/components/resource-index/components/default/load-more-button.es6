class DefaultLoadMoreButton extends React.Component {
  render() {
    const { title, loadAction } = this.props;
    let className = this._getClassName()
    return (
      <a href="#" onClick={loadAction} className={className}>
        Load More {title}
      </a>
    )
  }

  _getClassName() {
    let classNames = ['btn btn-comp', 'infinite-loader'];
    if (this.props.pagination) {
      const { totalPages, currentPage } = this.props.pagination;
      if (totalPages > currentPage) classNames.push('open');
    }
    return classNames.join(' ');
  }
}

window.ResourceIndexComponents.DefaultLoadMoreButton = DefaultLoadMoreButton;
