class DefaultRecord extends React.Component {
  render() {
    const { edit_path, title, delete_path, onDelete } = this.props;
    return (
      <li className="panel record">
        <p className="title">
          <a href={edit_path}>{title}</a>
        </p>
        <p className="detail">
          Posted on a Monday
        </p>

        <div className="actions">
          <a href={edit_path} title="Edit">
            <i className="icon ion-edit"></i>
          </a>

          <a href="#" onClick={onDelete} title='Delete'>
            <i className="icon ion-ios-trash"></i>
          </a>

          <a className="action dropdown-button" href="#!" data-activates="record-dropdown">
            <i className="icon ion-android-more-vertical"></i>
          </a>

          <ul className="dropdown-content" id="record-dropdown">
            <li>
              <a href={edit_path} title="Edit">
                <i className="icon ion-edit"></i>
                Test Edit
              </a>

              <a href="#" onClick={onDelete} title='Delete'>
                <i className="icon ion-ios-trash"></i>
                Test Delete
              </a>
            </li>
          </ul>
        </div>
      </li>
    )
  }
}

window.ResourceIndexComponents.DefaultRecord = DefaultRecord;
