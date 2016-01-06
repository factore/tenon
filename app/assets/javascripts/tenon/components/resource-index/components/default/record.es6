class DefaultRecord extends React.Component {
  render() {
    const { edit_path, title, delete_path, onDelete } = this.props;
    return (
      <li className="panel record">
        <div className="record-details">
          <p className="title expand-record">
            {title}
          </p>
          <p className="font-smallest expand-record">
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
        </div>
        <div className="record-expanded">
          <p className="color-primary">
            This is another title about things
          </p>
          <p className="font-smallest">
            <label className="color-light-fg">Notes:</label>
            <br/>
            Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
          </p>
          <div className="actions">
            <a href="#" title='Action Link'>
              Action Link
            </a>
            <a href="#" title='Another Link'>
              Another Link
            </a>
          </div>
        </div>
      </li>
    )
  }
}

window.ResourceIndexComponents.DefaultRecord = DefaultRecord;
