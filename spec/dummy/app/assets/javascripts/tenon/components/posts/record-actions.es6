window.ResourceIndexComponents.posts.RecordActions = (props) => {
  const editPath = props.record.edit_path;
  const { onDelete, record } = props;
  const { updateRecord } = props.handlers;

  return (
    <div className="record__actions">
      <Dropdown>
        <DropdownButton
          className="record__action-icon record__action-icon--kebab">
          <i className="material-icon">more_vert</i>
        </DropdownButton>

        <DropdownMenu>
          <li className="dropdown__item">
            <a className="dropdown__action" href={editPath}>
              <i className="material-icon">edit</i>
              <span>Edit</span>
            </a>
          </li>

          <li className="dropdown__item">
            <a
              className="dropdown__action" href="#!" onClick={onDelete}>
              <i className="material-icon">delete</i>
              <span>Delete</span>
            </a>
          </li>

          <li className="dropdown__item">
            <a
              className="dropdown__action"
              href="#!"
              onClick={(e) => {
                updateRecord(e, record, { featured: !record.featured });
              }}>
              <i className="material-icon">
                {record.featured ? 'star' : 'star_border'}
              </i>
              <span>Toggle Featured</span>
            </a>
          </li>
        </DropdownMenu>
      </Dropdown>

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
