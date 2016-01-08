class DefaultHeader extends React.Component {
  constructor(props) {
    super(props)
    this.state = { searchOpen: false };
  }

  render() {
    let searchClass = this.state.searchOpen ? 'open' : '';
    let searchIcon = this.state.searchOpen ? 'fa-times' : 'fa-search';
    let searchButton = this._renderSearchButton(searchClass, searchIcon)
    const { QuickSearch } = this.props.childComponents;

    return(
      <div className='toolbar'>
        <Breadcrumbs breadcrumbs={this.props.breadcrumbs} />

        <QuickSearch
        searchAction={this.props.actions.quickSearchRecords}
        searchClass={searchClass} />

        <div className="actions">
          <a className="action-text dropdown-button" href="#!" data-activates='toolbox-dropdown' title="Toolbox toggle">
            Advanced Search
          </a>

          <a className="action dropdown-button" href="#!" data-activates='dropdown' title="Links!">
            <i className="icon ion-android-more-vertical"></i>
          </a>

          <ul className="dropdown-content" id="dropdown">
            <li>
              <a href="#!">
              <i className="icon ion-ios-game-controller-a-outline"></i>
              Click
              </a>
            </li>
            <li>
              <a href="#!">
              <i className="icon ion-ios-analytics"></i>
              Another link
              </a>
            </li>
          </ul>
        </div>
      </div>


    )
  }

  _handleSearchToggle(e) {
    e.preventDefault();
    // Clear the query before closing
    if (this.state.searchOpen) this.props.actions.quickSearchRecords('');
    this.setState({searchOpen: !this.state.searchOpen});
  }

  _renderSearchButton(className, icon) {
    return (
      <div className="header-button">
        <a href="#" onClick={e => this._handleSearchToggle(e)} className={className}>
          <div className="header-icon">
            <i className={'fa fa-fw ' + icon}></i>
          </div>
        </a>
      </div>
    );
  }
}

window.ResourceIndexComponents.DefaultHeader = DefaultHeader;
