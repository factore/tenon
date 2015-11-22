class DefaultLoadMoreButton extends React.Component {
  render() {
    const { title, loadAction } = this.props;
    let className = this._getClassName()
    return (
      <a href="#" onClick={loadAction} className={className}>
        <i className='icon ion-loop'></i>
      </a>
    )
  }

  _getClassName() {
    let classNames = ['infinite-loader'];
    if (this.props.pagination) {
      const { totalPages, currentPage } = this.props.pagination;
      if (totalPages > currentPage) classNames.push('visible');
    }
    return classNames.join(' ');
  }
}

window.ResourceIndexComponents.DefaultLoadMoreButton = DefaultLoadMoreButton;
