/* global React */
class DefaultHeader extends React.Component {
  constructor(props) {
    super(props);
    this.state = { searchOpen: false };
  }

  render() {
    const searchClass = this.state.searchOpen ? 'open' : '';
    const { QuickSearch } = this.props.childComponents;

    return(
      <div className="toolbar">
        <Breadcrumbs breadcrumbs={this.props.breadcrumbs} />

        <QuickSearch
          q={this.props.data.query.q}
          searchAction={this.props.actions.quickSearchRecords}
          toggleQuickSearchAction={this.props.actions.toggleQuickSearch}
          searchClass={searchClass} />

        <div className="actions">
          <div className="action action__icon">
            <a className="action-icon action-icon--white dropdown-button" href="#!" data-activates="sort-dropdown" title="Sort or options?">
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
                  <i className="material-icon material-icon--flip-vertical">sort</i>
                  Z to A
                </a>
              </li>
            </ul>
          </div>
          <div className="action action__icon">
            <a className="action-icon action-icon--white dropdown-button" href="#!" data-activates="list-dropdown" title="Links!">
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
      </div>
    );
  }

  _handleSearchToggle(e) {
    e.preventDefault();
    // Clear the query before closing
    if (this.state.searchOpen) {
      this.props.actions.quickSearchRecords('');
    }
    this.setState({ searchOpen: !this.state.searchOpen });
  }

  _renderSearchButton(className, icon) {
    return (
      <div className="header-button">
        <a href="#" onClick={(e) => this._handleSearchToggle(e)} className={className}>
          <div className="header-icon">
            <i className="material-icon">{icon}></i>
          </div>
        </a>
      </div>
    );
  }
}

window.ResourceIndexComponents.DefaultHeader = DefaultHeader;
