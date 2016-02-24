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

        <ul className=".dropdown" id="sort-dropdown">
          <li className="dropdown__item dropdown__item--label">Dropdown Label</li>
          <li className="dropdown__item">
            <a href="#!" className="dropdown__icon action-icon">
              <i className="material-icon">sort</i>
              <span>A to Z</span>
            </a>
          </li>
          <li className="dropdown__item">
            <a href="#!" className="dropdown__icon action-icon">
              <i className="material-icon flip-vertical">sort</i>
              <span>Z to A</span>
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

        <ul className=".dropdown" id="list-dropdown">
          <li className="dropdown__item">
            <a href="#!" className="dropdown__icon action-icon">
              <i className="material-icon">apps</i>
              <span>Index Actions</span>
            </a>
          </li>
          <li className="dropdown__item">
            <a href="#!" className="dropdown__icon action-icon">
                <i className="material-icon">cloud_upload</i>
                <span>Import</span>
            </a>
          </li>
          <li className="dropdown__item">
            <a href="#!" className="dropdown__icon action-icon">
              <i className="material-icon">cloud_download</i>
              <span>Export</span>
            </a>
          </li>
        </ul>
      </div>
    </div>
  );
};
