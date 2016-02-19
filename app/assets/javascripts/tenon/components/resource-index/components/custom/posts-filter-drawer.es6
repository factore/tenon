window.ResourceIndexComponents.PostsFilterDrawer = ({ data, onChange }) => {
  const query = data.query;

  return (
    <div className="panel--block">
      <TextField
        label="Keywords"
        name="q"
        value={query.q}
        onChange={onChange} />

      <DatepickerField
        label="Start Date"
        name="start_date"
        value={query.start_date}
        onChange={onChange} />

      <DatepickerField
        label="End"
        name="end_date"
        value={query.end_date}
        onChange={onChange} />
    </div>
  );
};
