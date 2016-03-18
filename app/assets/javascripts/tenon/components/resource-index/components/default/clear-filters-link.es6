window.ResourceIndexComponents.DefaultClearFiltersLink = ({
  data: { query },
  actions: { replaceQuery }
}) => {
  const nonEmpty = query && _.pick(query, (v) => v && v.length);
  const keys = Object.keys(nonEmpty);
  const hasKeys = keys.length;
  const isFiltered = hasKeys && !_.isEqual(keys, ['page']);

  if (!isFiltered) {
    return <span></span>;
  }

  return (
    <button className="action-text" onClick={() => replaceQuery({ page: 1 })}>
      Clear filters
    </button>
  );
};
