window.ResourceIndexComponents.PostsRecordActions = (props) => {
  const editPath = props.record.edit_path;
  const { onDelete, record } = props;
  const { updateRecord } = props.handlers;

  return (
    <div className="record__actions">
      <a
        className="record__action-icon"
        href={editPath}
        title="Edit">
        <i className="material-icon">edit</i>
      </a>

      <a
        className="record__action-icon"
        href="#!"
        onClick={onDelete}
        title="Delete">
        <i className="material-icon">delete</i>
      </a>

      <a
        className="record__action-icon"
        href="#!"
        onClick={(e) => {
          updateRecord(e, record, { featured: !record.featured });
        }}
        title="Toggle Featured">
        <i className="material-icon">
          {record.featured ? 'star' : 'star_border'}
        </i>
      </a>
    </div>
  );
};
