class DefaultQuickSearch extends React.Component {
  constructor(props) {
    super(props);
    this._delayedChange = _.debounce(function (event, action) {
      action(event.target.value)
    }, 250);
  }

  componentDidUpdate() {
    if (this.props.searchClass == 'open') {
      React.findDOMNode(this.refs.searchInput).focus();
    }
  }

  render() {
    const { searchClass } = this.props;

    return (
      <div id="search-container" className={searchClass}>
        <section id="search" className="search-content">
          <input
            type="text"
            ref='searchInput'
            onChange={(e) => this._handleChange(e)}
            className="search-field"
            placeholder="Search..."
            title="Search" />

          <div className="actions">
            <a className="action-icon toggle-drawer filter-toggle" href="#!" title="Filter" data-target="filters">
              <i className="icon ion-android-options"></i>
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
            <a href="#" className="toolbar-action ">
              <i className="icon ion-android-arrow-back"></i>
              Clear
            </a>
          </div>

          <div className="filter-content">
            <a href="#" className="toolbar-action toggle-drawer" data-target="filters">
              <i className="icon ion-android-close"></i>
              Close
            </a>
            <div className="util-nav-content">
              123 Million Results!
            </div>
          </div>
        </div>


      </div>
    )
  }

  _handleChange(e) {
    e.persist();
    this._delayedChange(e, this.props.searchAction);
  }
}

window.ResourceIndexComponents.DefaultQuickSearch = DefaultQuickSearch;
