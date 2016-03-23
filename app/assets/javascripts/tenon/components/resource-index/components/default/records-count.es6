/* global pluralize */

window.ResourceIndexComponents.DefaultRecordsCount = (props) => {
  const { data: { pagination }, title } = props;
  const totalEntries = pagination.total_entries || 0;

  return (
    <span className="records-list__count">
      {pluralize(title, totalEntries, true)}
      {' '}
    </span>
  );
};
