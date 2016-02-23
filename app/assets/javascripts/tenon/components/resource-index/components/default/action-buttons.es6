window.ResourceIndexComponents.DefaultActionButtons = (props) => {
  let filterDrawerToggle = '';

  if (props.childComponents.FilterDrawer) {
    filterDrawerToggle = (
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
  }

  return (
    <div className="toolbar__actions toolbar__actions--right">
      {filterDrawerToggle}

      <div className="toolbar__action">
        <a
          className="action-icon dropdown-button"
          href="#!"
          data-activates="sort-dropdown"
          title="Sort or options?">
          <i className="material-icon">sort</i>
        </a>

        <ul className="dropdown-content" id="sort-dropdown">
          <li className="dropdown-label">Dropdown Label</li>
          <li className="divider"></li>
          <li>
            <a href="#!">
              <i className="material-icon">sort</i>
              A to Z
            </a>
          </li>
          <li>
            <a href="#!">
              <i className="material-icon flip-vertical">sort</i>
              Z to A
            </a>
          </li>
        </ul>
      </div>

      <div className="toolbar__action">
        <a
          className="action-icon dropdown-button"
          href="#!"
          data-activates="list-dropdown"
          title="Links!">
          <i className="material-icon">more_vert</i>
        </a>

        <ul className="dropdown-content" id="list-dropdown">
          <li>
            <a href="#!">
              <i className="material-icon">apps</i>
              Index Actions
            </a>
          </li>
          <li>
            <a href="#!">
                <i className="material-icon">cloud_upload</i>
                Import
            </a>
          </li>
          <li>
            <a href="#!">
              <i className="material-icon">cloud_download</i>
              Export
            </a>
          </li>
        </ul>
      </div>
    </div>
  );
};
