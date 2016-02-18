/* global React */

class DefaultQuickSearch extends React.Component {
  render() {
    const { q, onChange, onFocus, onBlur, onClickClear } = this.props;

    return (
      <div id="search-container">
        <section id="search" className="search-content">
          <i className="search-icon material-icon">search</i>
          <input
            type="text"
            ref="searchInput"
            name="q"
            value={q}
            onChange={onChange}
            onFocus={onFocus}
            onBlur={onBlur}
            className="search-field"
            placeholder="Search..."
            title="Search" />
        </section>

        <div id="search-overlay" className="toolbar-overlay">
          <div className="search-content">
            <a
              href="#!"
              className="toolbar-action"
              onClick={onClickClear}>
              <i className="material-icon">arrow_back</i>
              Clear
            </a>
          </div>
        </div>
      </div>
    );
  }
}

window.ResourceIndexComponents.DefaultQuickSearch = DefaultQuickSearch;
