import { Component } from 'react';

export default class App extends Component {
  render() {
    const {
      QuickSearchOverlay, QuickSearchToolbar, List, Filtering
    } = this.props.childComponents;
    const outerClassNames = [];

    if (this.props.ui.quickSearchOpen) {
      outerClassNames.push('quick-search-open');
    }

    if (this.props.ui.filterDrawerOpen) {
      outerClassNames.push('filter-drawer-open');
    }

    return (
      <div className={outerClassNames.join(' ')}>
        <QuickSearchToolbar { ...this.props } />
        <QuickSearchOverlay { ...this.props } />
        <Filtering { ...this.props } />
        <div className="drawer-pusher">
          <main>
            <a className="fab fab--bottom-right" href={this.props.newPath}>
              <i className="material-icon">add</i>
            </a>
            <List {...this.props} />
          </main>
        </div>
      </div>
    );
  }
}
