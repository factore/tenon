import React, { Component, PropTypes } from 'react';
import QuickSearch from './quick-search';

export default class Header extends Component {
  constructor(props) {
    super(props)
    this.state = { searchOpen: false };
  }

  render() {
    let searchClass = this.state.searchOpen ? 'open' : '';
    let searchIcon = this.state.searchOpen ? 'fa-times' : 'fa-search';
    let searchButton = this._renderSearchButton(searchClass, searchIcon)

    return(
      <div>
        <header>
          <h1>{this.props.title}</h1>
          <div className="tools">
            {searchButton}
          </div>
        </header>

        <div className="toolbox">
          <QuickSearch
            searchAction={this.props.searchAction}
            searchClass={searchClass} />
        </div>
      </div>
    )
  }

  _handleSearchToggle(e) {
    e.preventDefault();
    // Clear the query before closing
    if (this.state.searchOpen) this.props.searchAction('');
    this.setState({ searchOpen: !this.state.searchOpen });
  }

  _renderSearchButton(className, icon) {
    return(
      <div className="header-button">
        <a href="#" onClick={e => this._handleSearchToggle(e)} className={className}>
          <div className="header-icon">
            <i className={'fa fa-fw ' + icon}></i>
          </div>
        </a>
      </div>
    )
  }
}
