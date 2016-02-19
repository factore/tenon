/* global React */
class DefaultFiltering extends React.Component {
  _clearFilters(e) {
    e.preventDefault();
    this.props.actions.updateQuery({ q: '', page: 1 });
    this.props.actions.toggleQuickSearch('off');
  }

  _changeFilter(e) {
    const change = { page: 1 };

    change[e.target.name] = e.target.value;
    this.props.actions.updateQuery(change);
  }

  render() {
    const { FilterDrawer, QuickSearch, ActionButtons } = this.props.childComponents;
    const { actions } = this.props;

    let filterDrawer = '';
    let filterDrawerToggle = '';

    if (FilterDrawer) {
      filterDrawer = (
        <form
          id="filters"
          className="drawer">
          <FilterDrawer
            { ...this.props }
            onChange={(e) => this._changeFilter(e)} />
        </form>
      );

      filterDrawerToggle = (
        <div className='toolbar__action filter-toggle'>
          <a
            className="action-icon"
            onClick={actions.toggleFilterDrawer}
            href="#!"
            title="Filter">
            <i className="material-icons">tune</i>
          </a>
        </div>
      );
    }

    return (
      <div>
        <QuickSearch
            q={this.props.data.query.q}
            ActionButtons={ActionButtons}
            quickSearchOpen={this.props.ui.quickSearchOpen}
            onClickClear={(e) => this._clearFilters(e)}
            onFocus={() => actions.toggleQuickSearch('on')}
            onChange={(e) => this._changeFilter(e)}
            onBlur={(e) => {
              if (e.target.value === '') {
                actions.toggleQuickSearch('off');
              }
            }} />

        {filterDrawerToggle}
        {filterDrawer}

        <div className="toolbar-overlay">
          <div className="filter-content">
            <a href="#!" className="toolbar__action toggle-drawer" data-target="filters">
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

window.ResourceIndexComponents.DefaultFiltering = DefaultFiltering;
