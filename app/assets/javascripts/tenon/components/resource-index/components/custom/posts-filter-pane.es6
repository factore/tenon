window.ResourceIndexComponents.PostsFilterPane = ({data, onChange}) => {
  const query = data.query;

  return (
    <div>
      <label>Query</label>
      <input type="text" name="q" value={query.q} onChange={onChange} />

      <label>Start Date</label>
      <Datepicker
        name="start_date"
        value={query.start_date}
        onChange={onChange} />

      <label>End Date</label>
      <Datepicker
        name="end_date"
        value={query.end_date}
        onChange={onChange} />
    </div>
  );
};
