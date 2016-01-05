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
      <div id="quick-search-container" className={searchClass}>
        <input
          type="text"
          ref='searchInput'
          onChange={(e) => this._handleChange(e)}
          className="search"
          placeholder="Quick search" />
      </div>
    )
  }

  _handleChange(e) {
    e.persist();
    this._delayedChange(e, this.props.searchAction);
  }
}

window.ResourceIndexComponents.DefaultQuickSearch = DefaultQuickSearch;
