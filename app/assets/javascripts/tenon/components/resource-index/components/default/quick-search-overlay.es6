/* global classNames */
/* global React */
/* global ReactDOM */

() => {
  class QuickSearchOverlay extends React.Component {
    componentDidUpdate() {
      if (this.props.ui.quickSearchOpen) {
        const node = ReactDOM.findDOMNode(this._input);

        // node.querySelectorAll(':scope > input[type=text]')[0].focus();
      }
    }

    render() {
      const {
        ui: { quickSearchOpen },
        childComponents: { QuickSearchInput, FilterDrawerToggle },
        actions: { toggleQuickSearch, updateQuery }
      } = this.props;

      const className = classNames({
        'toolbar': true,
        'toolbar--quicksearch': true,
        'toolbar--overlay-z1': true,
        'toolbar--is-open': quickSearchOpen
      });

      return (
        <div className={className}>
          <div className="toolbar__actions toolbar__actions--left">
            <div className="toolbar__action">
              <a
                href="#!"
                className="action-icon"
                onClick={(e) => {
                  e.preventDefault();
                  toggleQuickSearch('off');
                  updateQuery({ q: '', page: 1 });
                }}>
                <i className="material-icon">arrow_back</i>
                <span className="hide-on-min">Clear</span>
              </a>
            </div>
          </div>

          <div className="toolbar__content">
            <QuickSearchInput
              ref={(input) => this._input = input}
              { ...this.props } />
          </div>

          <div className="toolbar__actions toolbar__actions--right">
            <FilterDrawerToggle {...this.props} />
          </div>
        </div>
      );
    }
  }

  window.ResourceIndexComponents.DefaultQuickSearchOverlay = QuickSearchOverlay;
}();
