/* global React */
class DefaultFiltering extends React.Component {
  _changeFilter(e) {
    const change = { page: 1 };

    change[e.target.name] = e.target.value;
    this.props.actions.updateQuery(change);
  }

  render() {
    const { FilterDrawer, FilterOverlay } = this.props.childComponents;
    const { toggleFilterDrawer } = this.props.actions;

    if (!FilterDrawer) {
      return <div></div>;
    }

    return (
      <div>
        <div className="filter-drawer">
          <FilterDrawer
            { ...this.props }
            onChange={(e) => this._changeFilter(e)} />

          <div className="filter-drawer__submit">
            <button
              className="btn btn--block"
              onClick={() => toggleFilterDrawer('off')}>
              Search
            </button>
          </div>
        </div>
        <FilterOverlay { ...this.props } />
      </div>
    );
  }
}

window.ResourceIndexComponents.DefaultFiltering = DefaultFiltering;
