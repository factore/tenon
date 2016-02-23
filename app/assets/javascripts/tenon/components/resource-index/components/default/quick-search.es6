/* global React */

class DefaultQuickSearch extends React.Component {
  render() {
    const {
      ui: { quickSearchOpen },
      childComponents: { QuickSearchInput, QuickSearchOverlay, ActionButtons }
    } = this.props;

    return (
      <div>
        <div className="toolbar">
          <Breadcrumbs breadcrumbs={this.props.breadcrumbs} />
          <div className="toolbar__content">
            <QuickSearchInput { ...this.props } />
            <ActionButtons { ...this.props } />
          </div>
        </div>
        <QuickSearchOverlay { ...this.props } />
      </div>
    );
  }
}

window.ResourceIndexComponents.DefaultQuickSearch = DefaultQuickSearch;
