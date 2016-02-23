/* global React */
class DefaultFiltering extends React.Component {
  _changeFilter(e) {
    const change = { page: 1 };

    change[e.target.name] = e.target.value;
    this.props.actions.updateQuery(change);
  }

  render() {
    const { FilterDrawer, FilterOverlay } = this.props.childComponents;
    const { actions } = this.props;

    if (!FilterDrawer) {
      return '<div></div>';
    }

    return (
      <div>
        <div id="filters" className="drawer">
          <FilterDrawer
            { ...this.props }
            onChange={(e) => this._changeFilter(e)} />
        </div>
        <FilterOverlay { ...this.props } />
      </div>
    );
  }
}

window.ResourceIndexComponents.DefaultFiltering = DefaultFiltering;
