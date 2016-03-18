/* global pluralize */

window.ResourceIndexComponents.DefaultRecordsCount = (props) => {
  const { data: { pagination }, title } = props;
  const totalEntries = pagination.total_entries || 0;

  return (
    <span className="records-count">
      {pluralize(title.toLowerCase(), totalEntries, true)} found.
      {' '}
    </span>
  );
};
