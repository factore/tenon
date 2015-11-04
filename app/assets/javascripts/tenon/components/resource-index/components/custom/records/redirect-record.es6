class RedirectRecord extends React.Component {
  render() {
    const { edit_path, title, delete_path, onDelete } = this.props;
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
            <a href={edit_path}>
              {this.props.in}
              <i className="fa fa-long-arrow-right"
                style={{margin: '0 20px', opacity: 0.3}} />
              {this.props.out}
            </a>
          </div>
        </div>
      </li>
    )
  }
}

window.ResourceIndexComponents.RedirectRecord = RedirectRecord;
