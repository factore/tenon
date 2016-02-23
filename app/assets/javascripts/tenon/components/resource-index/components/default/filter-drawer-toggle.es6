window.ResourceIndexComponents.DefaultFilterDrawerToggle = (props) => {
  if (!props.childComponents.FilterDrawer) {
    return <div></div>;
  }

  return (
    <div className="toolbar__action filter-toggle">
      <a
        className="action-icon"
        onClick={props.actions.toggleFilterDrawer}
        href="#!"
        title="Filter">
        <i className="material-icons">tune</i>
      </a>
    </div>
  );
};
