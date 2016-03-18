/* global classNames */
window.ResourceIndexComponents.DefaultLoadMoreButton = (props) => {
  const {
    data: { pagination, isFetching }, actions: { loadNextPage }
  } = props;
  const showLoader = pagination.total_pages > pagination.current_page;
  const className = classNames({
    'infinite-loader': true,
    'infinite-loader--is-visibile': showLoader,
    'infinite-loader--is-loading': isFetching
  });

  return (
    <button onClick={loadNextPage} className={className}>
      <i className="material-icon">loop</i>
    </button>
  );
};
