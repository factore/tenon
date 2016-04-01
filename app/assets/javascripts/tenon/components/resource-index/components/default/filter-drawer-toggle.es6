window.ResourceIndexComponents.DefaultFilterDrawerToggle = (props) => {
  if (!props.childComponents.FilterDrawer) {
    return <div></div>;
  }

  const classNames = ['toolbar__action'];

  if (props.className) {
    classNames.push(props.className);
  }

  return (
    <div className={classNames.join(' ')}>
      <a
        className="toolbar__action-icon"
        onClick={props.actions.toggleFilterDrawer}
        href="#!"
        title="Filter">
        <i className="material-icons">tune</i>
      </a>
    </div>
  );
};
