window.ResourceIndexComponents.DefaultQuickSearchInput = (props) => {
  const { onChange, onFocus, onBlur } = props;
  const q = props.data.query.q;

  return (
    <section id="search" className="search-content">
      <i className="search-content__icon material-icon">search</i>
      <input
        type="text"
        name="q"
        value={q}
        onChange={onChange}
        onFocus={onFocus}
        onBlur={onBlur}
        className="search-content__field"
        placeholder="Search..."
        title="Search" />
    </section>
  );
};
