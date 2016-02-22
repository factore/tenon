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
    const { FilterDrawer, QuickSearch } = this.props.childComponents;
    const { actions } = this.props;

    let filterDrawer = '';

    if (FilterDrawer) {
      filterDrawer = (
        <div id="filters" className="drawer">
          <FilterDrawer
            { ...this.props }
            onChange={(e) => this._changeFilter(e)} />
        </div>
      );
    }

    return (
      <div>
        {filterDrawer}

        <QuickSearch
            { ...this.props }
            onClickClear={(e) => this._clearFilters(e)}
            onFocus={() => actions.toggleQuickSearch('on')}
            onChange={(e) => this._changeFilter(e)}
            onBlur={(e) => {
              if (e.target.value === '') {
                actions.toggleQuickSearch('off');
              }
            }} />

        <div className="toolbar-overlay">
          <div className="filter-content">
            <a href="#!" className="toolbar__action">
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
