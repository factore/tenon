/* global Dropdown */
/* global DropdownButton */
/* global DropdownMenu */

window.ResourceIndexComponents.DefaultRecordActions = (props) => {
  const { record, onDelete, editWithModal } = props;
  const { editRecordInModal } = props.handlers;
  let editLinkOpts;

  if (editWithModal) {
    editLinkOpts = {
      href: '#!',
      onClick: (e) => editRecordInModal(e, record)
    };
  } else {
    editLinkOpts = { href: record.edit_path };
  }

  return (
    <div className="record__actions">
      <Dropdown>
        <DropdownButton
          className="record__action-icon record__action-icon--kebab">
          <i className="material-icon">more_vert</i>
        </DropdownButton>

        <DropdownMenu>
          <li className="dropdown__item">
            <a
              className="dropdown__action"
              { ...editLinkOpts }>
              <i className="material-icon">edit</i>
              <span>Edit</span>
            </a>
          </li>

          <li className="dropdown__item">
            <a className="dropdown__action" href="#!" onClick={onDelete}>
              <i className="material-icon">delete</i>
              <span>Delete</span>
            </a>
          </li>
        </DropdownMenu>
      </Dropdown>

      <a
        { ...editLinkOpts }
        className="record__action-icon"
        title="Edit">
        <i className="material-icon">edit</i>
      </a>

      <a
        href="#!"
        className="record__action-icon"
        onClick={onDelete}
        title="Delete">
        <i className="material-icon">delete</i>
      </a>
    </div>
  );
};
