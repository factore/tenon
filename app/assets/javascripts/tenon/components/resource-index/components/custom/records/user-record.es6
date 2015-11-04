class UserRecord extends React.Component {
  render() {
    const {
      edit_path, email, roles, last_login,
      delete_path, onDelete
    } = this.props;
    return (
      <li>
        <div className="record-details">
          <div className='record-actions'>
            <a onClick={onDelete} data-tooltip='Delete' title='Delete'>
              <i className="fa fa-trash"></i>
            </a>

            <a href={edit_path} data-tooltip="Edit" title="Edit">
              <i className="fa fa-pencil"></i>
            </a>
          </div>

          <div className="record-title">
            <a href={edit_path}>{email}</a>
            <br />
          </div>

          <div className="record-fields">
            <div className="record-field">
              Roles - {roles}
            </div>
            <div className="record-field">
              Last Login - {last_login}
            </div>
          </div>
        </div>
      </li>
    )
  }
}

window.UserRecord = UserRecord;
