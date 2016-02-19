/* global React */

class DefaultQuickSearch extends React.Component {
  render() {
    const {
      q, onChange, onFocus, onBlur,
      onClickClear, quickSearchOpen, ActionButtons
    } = this.props;
    let toolbarOverlayClassName = 'toolbar-overlay';
    const quickSearchInput = (
      <section id="search" className="search-content">
          <i className="search-content__icon material-icon">search</i>
          <input
            type="text"
            ref="searchInput"
            name="q"
            value={q}
            onChange={onChange}
            onFocus={onFocus}
            onBlur={onBlur}
            className="search-content__field"
            placeholder="Search..."
            title="Search" />
        </section>
    );

    if (quickSearchOpen) {
      toolbarOverlayClassName += ' toolbar-overlay--is-open';
    }

    return (
      <div id="search-container">
        {quickSearchInput}

        <div className={toolbarOverlayClassName}>
          <div className="toolbar-overlay__background"></div>
          <div className="toolbar-overlay__content">
            <div className="quick-search-content">
              <a
                href="#!"
                className="toolbar__action"
                onClick={onClickClear}>
                  <i className="material-icon">arrow_back</i>
                Clear
              </a>

              {quickSearchInput}
              {this.props.ActionButtons}
            </div>
          </div>
        </div>
      </div>
    );
  }
}

window.ResourceIndexComponents.DefaultQuickSearch = DefaultQuickSearch;
