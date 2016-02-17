class ContactRecord extends React.Component {
  render() {
    const { edit_path, title, delete_path, onDelete, onUpdate } = this.props;
    let readToggleText;
    let readToggleIcon;
    if (this.props.is_read) {
      readToggleText = 'Mark as Read';
      readToggleIcon = 'folder-open-o';
    } else {
      readToggleText = 'Mark as Unread';
      readToggleIcon = 'folder-open';
    }

    return (
      <li>
        <div className="record-details">
          <div className='record-actions'>
            <a href='#' onClick={onDelete} data-tooltip='Delete' title='Delete'>
              <i className="material-icons">delete</i>
            </a>

            <a
              href='#'
              data-modal-target={'#contact-' + this.props.id}
              data-modal-title='Contact Details'
              data-tooltip='View Contact Details'
              title='View Contact Details'>
              <i className="material-icons">visibility</i>
            </a>

            <a
              href='#'
              onClick={(e) => onUpdate(e, {is_read: !this.props.is_read})}
              data-tooltip={readToggleText}
              title={readToggleText}>
              <i className={'fa fa-' + readToggleIcon}></i>
            </a>

          </div>

          <div className="record-title">
            From: {' '}
            <strong>
              <a href={'mailto:' + this.props.email}>{this.props.name} ({this.props.email})</a>
            </strong>
            <br />

            <small>
              Sent on: {' '}
              <strong>
                {this.props.sent_date}
              </strong>
            </small>
            <br />

            <small>{this.props.content}</small>
            <div style={{display: 'none'}} id={'contact-' + this.props.id}>
              <p>{this.props.content}</p>
              <hr />
              <p>
                <strong>Name: </strong>
                {this.props.name}
              </p>

              <p>
                <strong>Email: </strong>
                <a href={'mailto:' + this.props.email}>{this.props.email}</a>
              </p>

              <p>
                <strong>Phone: </strong>
                {this.props.phone}
              </p>

              <p>
                <strong>IP:</strong>
                {this.props.user_ip}
              </p>
              <p>
                <strong>Agent:</strong>
                {this.props.user_agent}
              </p>
              <p>
                <strong>Referrer:</strong>
                {this.props.referrer}
              </p>
            </div>
          </div>
        </div>
      </li>
    )
  }
}

window.ResourceIndexComponents.ContactRecord = ContactRecord;
