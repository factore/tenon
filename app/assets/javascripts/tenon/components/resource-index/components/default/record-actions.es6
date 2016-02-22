window.ResourceIndexComponents.DefaultRecordActions = (props) => {
  const editPath = props.record.edit_path;
  const onDelete = props.onDelete;

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
        onClick={onDelete} title="Delete">
        <i className="material-icon">delete</i>
      </a>

      <a
        className="record__action-icon dropdown-button"
        href="#!"
        data-activates="record-dropdown">
        <i className="material-icon">more_vert</i>
      </a>

      <ul className="dropdown-content" id="record-dropdown">
        <li>
          <a href={editPath} title="Edit">
            <i className="material-icon">edit</i>
            Test Edit
          </a>

          <a href="#!" onClick={onDelete} title="Delete">
            <i className="material-icon">delete</i>
            Test Delete
          </a>
        </li>
      </ul>
    </div>
  );
};
