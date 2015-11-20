class DefaultRecord extends React.Component {
  render() {
    const { edit_path, title, delete_path, onDelete } = this.props;
    return (
      <li className="record">
        <span className="title">
          <a href={edit_path}>{title}</a>
        </span>

        <div className="secondary-content">
          <a href={edit_path} title="Edit">
            <i className="fa fa-pencil"></i> Edit
          </a>

          <a href="#" onClick={onDelete} title='Delete'>
            <i className="fa fa-trash"></i> Delete
          </a>
        </div>
      </li>
    )
  }
}

window.ResourceIndexComponents.DefaultRecord = DefaultRecord;
