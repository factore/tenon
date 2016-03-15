window.ResourceIndexComponents.DefaultRecordActions = (props) => {
  const { record, onDelete, editWithModal } = props;
  const { editRecordInModal } = props.handlers;
  let editLinkOpts;

  if (editWithModal) {
    editLinkOpts = { href: '#!', onClick: (e) => editRecordInModal(e, record) };
  } else {
    editLinkOpts = { href: record.edit_path };
  }

  return (
    <div className="record__actions">
      <a
        { ...editLinkOpts }
        className="record__action-icon"
        title="Edit">
        <i className="material-icon">edit</i>
      </a>

      <a
        className="record__action-icon"
        href="#!"
        onClick={onDelete} title="Delete">
        <i className="material-icon">delete</i>
      </a>
    </div>
  );
};
