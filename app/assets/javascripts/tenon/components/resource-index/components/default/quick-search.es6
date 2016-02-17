/* global React */

class DefaultQuickSearch extends React.Component {
  constructor(props) {
    super(props);
    this._delayedChange = _.debounce(function(value, action) {
      action(value);
    }, 500);
  }

  componentWillMount() {
    this.setState({ inputValue: this.props.q });
  }

  componentDidUpdate() {
    if (this.props.searchClass === 'open') {
      React.findDOMNode(this.refs.searchInput).focus();
    }
  }

  _handleChange(e) {
    this.setState({ inputValue: e.target.value }, () => {
      this._delayedChange(this.state.inputValue, this.props.searchAction);
    });
  }

  _handleFocus() {
    this.props.toggleQuickSearchAction('on');
  }

  _handleBlur(e) {
    if (e.target.value === '') {
      this.props.toggleQuickSearchAction('off');
    }
  }

  _handleClear(e) {
    e.preventDefault();
    this.props.searchAction('');
    this.props.toggleQuickSearchAction('off');
    this.setState({ inputValue: '' });
  }

  render() {
    const { searchClass } = this.props;

    return (
      <div id="search-container" className={searchClass}>
        <section id="search" className="search-content">
          <i className="search-icon material-icons">search</i>
          <input
            type="text"
            ref="searchInput"
            value={this.state.inputValue}
            onChange={(e) => this._handleChange(e)}
            onFocus={(e) => this._handleFocus(e)}
            onBlur={(e) => this._handleBlur(e)}
            className="search-field"
            placeholder="Search..."
            title="Search" />

          <div className="actions">
            <a className="action-icon toggle-drawer filter-toggle" href="#!" title="Filter" data-target="filters">
              <i className="material-icons">tune</i>
            </a>
          </div>
        </section>

        <section id="filters" className="drawer">
          <p>
          This is the filter pane.
          </p>
        </section>

        <div id="search-overlay" className="toolbar-overlay">
          <div className="search-content">
            <a
              href="#"
              className="toolbar-action"
              onClick={(e) => this._handleClear(e)}>
              <i className="material-icons">arrow_back</i>
              Clear
            </a>
          </div>

          <div className="filter-content">
            <a href="#" className="toolbar-action toggle-drawer" data-target="filters">
              <i className="material-icons">close</i>
              Close
            </a>
            <div className="util-nav-content">
              123 Million Results!
            </div>
          </div>
        </div>
      </div>
    );
  }
}

window.ResourceIndexComponents.DefaultQuickSearch = DefaultQuickSearch;
