window.ResourceIndexComponents.DefaultQuickSearchToggle = (props) => {
  return (
    <div className="toolbar__action hide-at-md">
      <button
        className="toolbar__action-icon"
        onClick={props.actions.toggleQuickSearch}
        title="Search">
        <i className="material-icons">search</i>
      </button>
    </div>
  );
};
