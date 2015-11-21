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
      <header>
        <div className="spacer"></div>

        <div className="toolbox">
          <QuickSearch
            searchAction={this.props.actions.quickSearchRecords}
            searchClass={searchClass} />
        </div>
      </header>
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
