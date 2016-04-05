/* global React */
() => {
  class Component extends React.Component {
    _clearFilters(e) {
      e.preventDefault();
      this.props.actions.replaceQuery({ page: 1 });
      this.props.actions.toggleQuickSearch('off');
    }

    render() {
      const { updateQuery } = this.props.actions;
      const { onFocus, onBlur } = this.props;
      const q = this.props.data.query.q;

      return (
        <section className={'search-content ' + this.props.className}>
          <i className="search-content__icon material-icon">search</i>
          <input
            type="text"
            name="q"
            value={q}
            onChange={(e) => updateQuery({ q: e.target.value, page: 1 })}
            onFocus={onFocus}
            onBlur={onBlur}
            className="search-content__field"
            placeholder="Search"
            title="Search" />
        </section>
      );
    }
  }

  window.ResourceIndexComponents.DefaultQuickSearchInput = Component;
}();
