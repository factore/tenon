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
    const { FilterPane, QuickSearch } = this.props.childComponents;
    const { actions } = this.props;

    let filterPane = '';
    let filterPaneToggle = '';

    if (FilterPane) {
      filterPane = (
        <form
          id="filters"
          className="drawer">
          <FilterPane
            { ...this.props }
            onChange={(e) => this._changeFilter(e)} />
        </form>
      );

      filterPaneToggle = (
        <a className="action-icon toggle-drawer filter-toggle" href="#!" title="Filter" data-target="filters">
          <i className="material-icons">tune</i>
        </a>
      );
    }

    return (
      <div>
        <QuickSearch
            q={this.props.data.query.q}
            onClickClear={(e) => this._clearFilters(e)}
            onFocus={() => actions.toggleQuickSearch('on')}
            onChange={(e) => {
              actions.updateQuery({ q: e.target.value, page: 1 });
            }}
            onBlur={(e) => {
              if (e.target.value === '') {
                actions.toggleQuickSearch('off');
              }
            }} />

        {filterPaneToggle}
        {filterPane}
      </div>
    );
  }
}

window.ResourceIndexComponents.DefaultFiltering = DefaultFiltering;
