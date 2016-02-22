/* global React */

class DefaultQuickSearch extends React.Component {
  render() {
    const {
      ui: { quickSearchOpen },
      childComponents: { QuickSearchInput, QuickSearchOverlay }
    } = this.props;

    return (
      <div className="search-container">
        <QuickSearchInput { ...this.props } />
        <QuickSearchOverlay { ...this.props } />
      </div>
    );
  }
}

window.ResourceIndexComponents.DefaultQuickSearch = DefaultQuickSearch;
