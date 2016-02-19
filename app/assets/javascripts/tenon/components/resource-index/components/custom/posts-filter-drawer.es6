window.ResourceIndexComponents.PostsFilterDrawer = ({ data, onChange }) => {
  const query = data.query;

  return (
    <div>
      <div className="panel--block">
        <div className="input-block">
          <label className="input-block__label">Query</label>
          <input
            className="input-block__text-input"
            type="text"
            name="q"
            value={query.q}
            onChange={onChange} />
        </div>

        <label className="input-block__label">Start Date</label>
        <Datepicker
          className="input-block__text-input"
          name="start_date"
          value={query.start_date}
          onChange={onChange} />

        <label className="input-block__label">End Date</label>
        <Datepicker
          className="input-block__text-input"
          name="end_date"
          value={query.end_date}
          onChange={onChange} />
      </div>
    </div>
  );
};
